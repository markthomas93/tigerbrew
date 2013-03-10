require 'formula'

class ApktoolExecutables < Formula
  url 'https://android-apktool.googlecode.com/files/apktool-install-macosx-r05-ibot.tar.bz2'
  sha1 'c2fb262760ccd27530e58ccc4bbef4d4a7b0ab39'
end

class Apktool < Formula
  homepage 'http://android-apktool.googlecode.com/'
  url 'https://android-apktool.googlecode.com/files/apktool1.5.1.tar.bz2'
  sha1 '73a0864d6910f40e6837b2777e2761a2952810eb'

  def install
    libexec.install 'apktool.jar'

    ApktoolExecutables.new.brew do |f|
      libexec.install 'aapt', 'apktool'
    end

    # Make apktool look for jar and aapkt in libexec
    inreplace "#{libexec}/apktool" do |s|
      s.gsub! /^libdir=.*$/, "libdir=\"#{libexec}\""
      s.gsub! "PATH=$PATH:`pwd`;", "PATH=$PATH:#{libexec};"
    end

    bin.install_symlink libexec/'apktool'
  end
end