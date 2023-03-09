import 'package:flutter/material.dart';

import '../../../stream_video_flutter.dart';
import '../../utils/extensions.dart';
import '../common/call_background.dart';
import '../common/calling_participants.dart';
import '../common/participant_avatars.dart';
import 'incoming_call_controls.dart';

/// Represents the Incoming Call state and UI, when the user is called by
/// other people.
class StreamIncomingCallContent extends StatefulWidget {
  const StreamIncomingCallContent({
    super.key,
    required this.call,
    required this.callState,
    this.onAcceptCallTap,
    this.onDeclineCallTap,
    this.onMicrophoneTap,
    this.onCameraTap,
    this.singleParticipantAvatarTheme,
    this.multipleParticipantAvatarTheme,
    this.singleParticipantTextStyle,
    this.multipleParticipantTextStyle,
    this.callingLabelTextStyle,
  });

  /// Represents a call.
  final Call call;

  /// Holds information about the call.
  final CallState callState;

  /// The action to perform when the accept call button is tapped.
  final VoidCallback? onAcceptCallTap;

  /// The action to perform when the decline call button is tapped.
  final VoidCallback? onDeclineCallTap;

  /// The action to perform when the microphone button is tapped.
  final VoidCallback? onMicrophoneTap;

  /// The action to perform when the camera button is tapped.
  final VoidCallback? onCameraTap;

  /// Theme for the avatar in a call with one participant.
  final StreamUserAvatarThemeData? singleParticipantAvatarTheme;

  /// Theme for the avatar in a call with multiple participants.
  final StreamUserAvatarThemeData? multipleParticipantAvatarTheme;

  /// Text style for the participant label in a call with one participant.
  final TextStyle? singleParticipantTextStyle;

  /// Text style for the participant label in a call with multiple participants.
  final TextStyle? multipleParticipantTextStyle;

  /// Text style for the calling label.
  final TextStyle? callingLabelTextStyle;

  @override
  State<StreamIncomingCallContent> createState() =>
      _StreamIncomingCallContentState();
}

class _StreamIncomingCallContentState extends State<StreamIncomingCallContent> {
  CallConnectOptions get options => widget.call.getInitialCallOptions();
  MicrophoneTrackOption get microphoneTrackOption => options.microphone;
  CameraTrackOption get cameraTrackOption => options.camera;

  @override
  Widget build(BuildContext context) {
    final theme = StreamIncomingOutgoingCallTheme.incomingCallThemeOf(context);

    final singleParticipantAvatarTheme = widget.singleParticipantAvatarTheme ??
        theme.singleParticipantAvatarTheme;
    final multipleParticipantAvatarTheme =
        widget.multipleParticipantAvatarTheme ??
            theme.multipleParticipantAvatarTheme;
    final singleParticipantTextStyle =
        widget.singleParticipantTextStyle ?? theme.singleParticipantTextStyle;
    final multipleParticipantTextStyle = widget.multipleParticipantTextStyle ??
        theme.multipleParticipantTextStyle;
    final callingLabelTextStyle =
        widget.callingLabelTextStyle ?? theme.callingLabelTextStyle;

    final users =
        widget.callState.otherParticipants.map((e) => e.toUserInfo()).toList();

    return CallBackground(
      participants: users,
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            ParticipantAvatars(
              participants: users,
              singleParticipantAvatarTheme: singleParticipantAvatarTheme,
              multipleParticipantAvatarTheme: multipleParticipantAvatarTheme,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 32),
              child: CallingParticipants(
                participants: users,
                singleParticipantTextStyle: singleParticipantTextStyle,
                multipleParticipantTextStyle: multipleParticipantTextStyle,
              ),
            ),
            Text(
              'Incoming Call...',
              style: callingLabelTextStyle,
            ),
            const Spacer(),
            IncomingCallControls(
              isMicrophoneEnabled: microphoneTrackOption.enabled,
              isCameraEnabled: cameraTrackOption.enabled,
              onAcceptCallTap: _onAcceptCallTap,
              onDeclineCallTap: () => _onDeclineCallTap(context),
              onMicrophoneTap: () => _onMicrophoneTap(context),
              onCameraTap: () => _onCameraTap(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onDeclineCallTap(BuildContext context) async {
    if (widget.onDeclineCallTap != null) {
      widget.onDeclineCallTap!();
    } else {
      await widget.call.apply(const RejectCall());
      await widget.call.disconnect();

      await Navigator.maybePop(context);
    }
  }

  Future<void> _onAcceptCallTap() async {
    if (widget.onAcceptCallTap != null) {
      widget.onAcceptCallTap!();
    } else {
      await widget.call.apply(const AcceptCall());
    }
  }

  Future<void> _onMicrophoneTap(BuildContext context) async {
    if (widget.onMicrophoneTap != null) {
      widget.onMicrophoneTap!();
    } else {
      widget.call.setInitialCallOptions(
        options.copyWith(
          microphone: MicrophoneTrackOption(
            enabled: !microphoneTrackOption.enabled,
          ),
        ),
      );
      return setState(() => {});
    }
  }

  Future<void> _onCameraTap(BuildContext context) async {
    if (widget.onCameraTap != null) {
      widget.onCameraTap!();
    } else {
      widget.call.setInitialCallOptions(
        options.copyWith(
          camera: CameraTrackOption(
            enabled: !cameraTrackOption.enabled,
          ),
        ),
      );
      return setState(() => {});
    }
  }
}
