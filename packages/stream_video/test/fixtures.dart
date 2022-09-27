import 'package:stream_video/src/sdp-transform/models.dart';

final expectedParsedSdp = ParsedSdp(
    version: 0,
    origin: Origin(
        username: '-',
        sessionId: 20518,
        sessionVersion: 0,
        netType: 'IN',
        ipVer: 4,
        address: '203.0.113.1'),
    name: '',
    timing: Timing(start: 0, stop: 0),
    connection: Connection(version: 4, ip: '203.0.113.1'),
    iceUfrag: 'F7gI',
    icePwd: 'x9cml/YzichV2+XlhiMu8g',
    fingerprint: Fingerprint(
        type: 'sha-1',
        hash: '42:89:c5:c6:55:9d:6e:c8:e8:83:55:2a:39:f9:b6:eb:e9:a3:a9:e7'),
    media: <Media>[
      Media(
          rtp: <Rtp>[
            Rtp(payload: 97, codec: 'H264', rate: 90000),
            Rtp(payload: 98, codec: 'VP8', rate: 90000)
          ],
          fmtp: <Fmtp>[
            Fmtp(
                payload: 97,
                config: 'profile-level-id=4d0028;packetization-mode=1')
          ],
          type: 'video',
          port: 55400,
          protocol: 'RTP/SAVPF',
          payloads: '97 98',
          direction: 'sendrecv',
          candidates: <Candidate>[
            Candidate(
                foundation: 0,
                component: 1,
                transport: 'UDP',
                priority: 2113667327,
                ip: '203.0.113.1',
                port: 55400,
                type: 'host'),
            Candidate(
                foundation: 1,
                component: 2,
                transport: 'UDP',
                priority: 2113667326,
                ip: '203.0.113.1',
                port: 55401,
                type: 'host')
          ])
    ]);
