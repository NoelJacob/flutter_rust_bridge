use crate::codegen::ir::early_generator::pack::IrEarlyGeneratorPack;
use crate::codegen::parser::hir::flat::extra_code_injector::{
    inject_extra_codes, InjectExtraCodeBlock,
};
use crate::codegen::parser::mir::internal_config::ParserMirInternalConfig;
use crate::codegen::parser::mir::parser::attribute::FrbAttributes;
use crate::utils::basic_code::parser::parse_dart_code;

pub(crate) fn generate(
    pack: &mut IrEarlyGeneratorPack,
    config_mir: &ParserMirInternalConfig,
) -> anyhow::Result<()> {
    if !should_enable_ui(pack)? {
        return Ok(());
    }

    let output_namespace = &(config_mir.rust_input_namespace_pack).rust_output_path_namespace;
    inject_extra_codes(
        &mut pack.hir_flat_pack,
        output_namespace,
        &[InjectExtraCodeBlock {
            code: generate_rust_boilerplate(),
            should_parse: true,
        }],
    )?;

    pack.hir_flat_pack.extra_dart_output_code += parse_dart_code(&generate_dart_boilerplate());

    Ok(())
}

fn should_enable_ui(pack: &mut IrEarlyGeneratorPack) -> anyhow::Result<bool> {
    for ty in &pack.hir_flat_pack.structs {
        let attr = FrbAttributes::parse(&ty.src.attrs)?;
        if attr.ui_state() {
            return Ok(true);
        }
    }
    Ok(false)
}

fn generate_rust_boilerplate() -> String {
    r###"
#[flutter_rust_bridge::frb(opaque)]
#[flutter_rust_bridge::frb(dart_code = r#"
    factory BaseRustState({required void Function() onMutate}) {
        final object = BaseRustState.empty();
        object.createNotifyUiStream().listen((_) => onMutate());
        return object;
    }
"#)]
#[derive(Default)]
pub struct BaseRustState {
    notify_ui: Option<StreamSink<()>>,
}

impl BaseRustState {
    #[flutter_rust_bridge::frb(sync)]
    pub fn empty() -> Self {
        Self { notify_ui: None }
    }

    #[flutter_rust_bridge::frb(sync)]
    pub fn create_notify_ui_stream(&mut self, sink: StreamSink<()>) {
        self.notify_ui = Some(sink);
    }

    #[flutter_rust_bridge::frb(ignore)]
    pub(crate) fn on_mutation(&self) {
        self.notify_ui.as_ref().unwrap().add(()).unwrap()
    }
}
    "###
    .to_owned()
}

fn generate_dart_boilerplate() -> String {
    r###"
import 'package:flutter/material.dart';
abstract class RustWidget extends StatefulWidget {
  final RustState state;

  const RustWidget({super.key, required this.state});

  @override
  State<RustWidget> createState() => _RustWidgetState();

  Widget build(BuildContext context);
}

class _RustWidgetState extends State<RustWidget> {
  late final BaseRustState baseState;

  @override
  void initState() {
    super.initState();
    baseState = BaseRustState(onMutate: () {
      if (mounted) setState(() {});
    });
    widget.state.setBaseState(baseState: baseState);
  }

  @override
  void dispose() {
    baseState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }
}
    "###
    .to_owned()
}
