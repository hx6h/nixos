{ config, pkgs, ... }:

# PipeWire audio stack, including the WirePlumber policy for bluetooth audio.
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    extraConfig.pipewire."92-buffer-size" = {
      "context.properties" = {
        "default.clock.quantum" = 1024;
        "default.clock.min-quantum" = 512;
        "default.clock.max-quantum" = 2048;
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [ 48000 ];
      };
    };

    wireplumber.extraConfig = {
      "10-bluez" = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;

          "bluez5.roles" = [ "a2dp_sink" "a2dp_source" "bap_sink" "bap_source" ];
          "bluez5.auto-connect" = [ "a2dp_sink" "bap_sink" ];

          "bluez5.enable-battery-volume" = false;
        };
      };

      "11-bluetooth-policy" = {
        "wireplumber.settings" = {
          "bluetooth.autoswitch-to-headset-profile" = false;
        };
      };
    };
  };
}
