import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'custom_appbar_model.dart';
export 'custom_appbar_model.dart';

class CustomAppbarWidget extends StatefulWidget {
  const CustomAppbarWidget({
    super.key,
    required this.backButton,
    bool? actionButton,
    this.actionButtonText,
    this.actionButtonAction,
    bool? optionsButton,
    required this.optionsButtonAction,
  })  : this.actionButton = actionButton ?? false,
        this.optionsButton = optionsButton ?? false;

  final bool? backButton;
  final bool actionButton;
  final String? actionButtonText;
  final Future Function()? actionButtonAction;
  final bool optionsButton;
  final Future Function()? optionsButtonAction;

  @override
  State<CustomAppbarWidget> createState() => _CustomAppbarWidgetState();
}

class _CustomAppbarWidgetState extends State<CustomAppbarWidget> {
  late CustomAppbarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomAppbarModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (widget.backButton ?? true)
          FlutterFlowIconButton(
            borderColor: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: 24,
            borderWidth: 1,
            buttonSize: 44,
            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 18,
            ),
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (widget.actionButton)
              FFButtonWidget(
                onPressed: () async {
                  await widget.actionButtonAction?.call();
                },
                text: valueOrDefault<String>(
                  widget.actionButtonText,
                  'Button',
                ),
                options: FFButtonOptions(
                  height: 44,
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Plus Jakarta Sans',
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    fontWeight: FontWeight.w600,
                  ),
                  elevation: 0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            if (widget.optionsButton)
              FlutterFlowIconButton(
                borderColor: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: 24,
                borderWidth: 1,
                buttonSize: 44,
                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                icon: FaIcon(
                  FontAwesomeIcons.ellipsisH,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 18,
                ),
                onPressed: () async {
                  await widget.optionsButtonAction?.call();
                },
              ),
          ].divide(SizedBox(width: 8)),
        ),
      ],
    );
  }
}
