class ClaudePanel < Formula
  desc "Terminal dashboard for Claude Code: plan limits, token usage, skills, plugins and MCP servers"
  homepage "https://github.com/ToroVtn/claude-panel"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ToroVtn/claude-panel/releases/download/v0.1.0/claude-panel-aarch64-apple-darwin.tar.xz"
      sha256 "39205c9b931ddfa283d194f5af5e7abe5862d3d9813589cf4e65929ab10b8e7c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ToroVtn/claude-panel/releases/download/v0.1.0/claude-panel-x86_64-apple-darwin.tar.xz"
      sha256 "da5a2b37e98b01744ba218ead22d2b0f2baba2a8962ed49cfbfbcf8b745938f9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ToroVtn/claude-panel/releases/download/v0.1.0/claude-panel-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "681de1c8dfff665690cfef8888e04eda34cf7427447f2c7d1928dd67fc711d1a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ToroVtn/claude-panel/releases/download/v0.1.0/claude-panel-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b92e9e317b7bc69ee6aa174a9090910981e22d78650c39d307f37e4c9f020df2"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "claude-panel"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "claude-panel"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "claude-panel"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "claude-panel"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
