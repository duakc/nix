{ pkgs, ... }:
{
  # fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    jetbrains-mono noto-fonts
    noto-fonts-cjk-sans # 黑体风格
    noto-fonts-cjk-serif # 宋体风格
    noto-fonts-color-emoji
    
    # 思源黑体 思源宋体
    source-han-sans source-han-serif
    
    # 更纱黑体 中英文等宽对齐
    sarasa-gothic 
  ];
}
