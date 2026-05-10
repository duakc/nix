{ ... }:
{
  environment.etc."sysctl.conf" = {
    enable = true;
    text = ''
      kern.maxfiles=6815744
      kern.maxfilesperproc=6815744
      net.inet.tcp.win_scale_factor=8
      net.inet.tcp.autorcvbufmax=33554432
      net.inet.tcp.autosndbufmax=33554432
      net.inet.tcp.recvspace=87380
      net.inet.tcp.sendspace=16384
      net.inet.tcp.sack=1
      net.inet.tcp.ecn=0
      net.inet.ip.forwarding=1
      net.inet6.ip6.forwarding=1
      kern.ipc.maxsockbuf=4194304
   '';
  };
}
