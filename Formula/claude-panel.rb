class ClaudePanel < Formula
  desc "Terminal dashboard for Claude Code: plan limits, token usage, skills, plugins and MCP servers"
  homepage "https://github.com/ToroVtn/claude-panel"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ToroVtn/claude-panel/releases/download/v0.1.1/claude-panel-aarch64-apple-darwin.tar.xz"
      sha256 "252d0b5d65bab454e2afe5f583e05885f7bac55059db0b7ea72908e3517cac3a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ToroVtn/claude-panel/releases/download/v0.1.1/claude-panel-x86_64-apple-darwin.tar.xz"
      sha256 "28f64682197b2afdf176d40cc69fb2ec52c20183ff89a6de7cb6482e3f51bda0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ToroVtn/claude-panel/releases/download/v0.1.1/claude-panel-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bd0c4d52724a75a6a3c1617c63733cb6bbcdd9f5fc9189bc7fe6cbc605ed2706"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ToroVtn/claude-panel/releases/download/v0.1.1/claude-panel-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "41dec3cbb32f1172a60c23af7bdf427fead94e20db3a63e22c22735e6fe56b8d"
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
