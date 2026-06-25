{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fcitx5-pinyin-zhwiki
    fcitx5-pinyin-moegirl
    fcitx5-pinyin-minecraft
  ];

  home.file = {
    "fcitx5-pinyin-dicts/web-slang.dict" = {
      source = "${pkgs.fcitx5-pinyin-zhwiki}/share/fcitx5/pinyin/dictionaries/web-slang.dict";
      target = ".local/share/fcitx5/pinyin/dictionaries/web-slang.dict";
    };
    "fcitx5-pinyin-dicts/zhwiki.dict" = {
      source = "${pkgs.fcitx5-pinyin-zhwiki}/share/fcitx5/pinyin/dictionaries/zhwiki.dict";
      target = ".local/share/fcitx5/pinyin/dictionaries/zhwiki.dict";
    };
    "fcitx5-pinyin-dicts/zhwikisource.dict" = {
      source = "${pkgs.fcitx5-pinyin-zhwiki}/share/fcitx5/pinyin/dictionaries/zhwikisource.dict";
      target = ".local/share/fcitx5/pinyin/dictionaries/zhwikisource.dict";
    };
    "fcitx5-pinyin-dicts/zhwiktionary.dict" = {
      source = "${pkgs.fcitx5-pinyin-zhwiki}/share/fcitx5/pinyin/dictionaries/zhwiktionary.dict";
      target = ".local/share/fcitx5/pinyin/dictionaries/zhwiktionary.dict";
    };

    "fcitx5-pinyin-dicts/moegirl.dict" = {
      source = "${pkgs.fcitx5-pinyin-moegirl}/share/fcitx5/pinyin/dictionaries/moegirl.dict";
      target = ".local/share/fcitx5/pinyin/dictionaries/moegirl.dict";
    };

    "fcitx5-pinyin-dicts/minecraft.dict" = {
      source = "${pkgs.fcitx5-pinyin-minecraft}/share/fcitx5/pinyin/dictionaries/minecraft.dict";
      target = ".local/share/fcitx5/pinyin/dictionaries/minecraft.dict";
    };
  };
}
