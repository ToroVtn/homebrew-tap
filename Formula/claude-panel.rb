class ClaudePanel < Formula
  desc "Terminal dashboard for Claude Code: plan limits, token usage, skills, plugins, MCP servers and hooks"
  homepage "https://github.com/ToroVtn/claude-panel"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ToroVtn/claude-panel/releases/download/v0.1.2/claude-panel-aarch64-apple-darwin.tar.xz"
      sha256 "bdf2d16931f54cff08ed2ceb76fd9cb11861fde06f4e24e7ac8da39883a540d9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ToroVtn/claude-panel/releases/download/v0.1.2/claude-panel-x86_64-apple-darwin.tar.xz"
      sha256 "2956834d98c1739127c8dc37c42d7e050cdc06147005e8636e9c457e7ad3ad28"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ToroVtn/claude-panel/releases/download/v0.1.2/claude-panel-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2d78a73205eed978fd35362f8a60f7872b965d391fe4d87db66ad5243889eb8b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ToroVtn/claude-panel/releases/download/v0.1.2/claude-panel-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "05623ee844a26d115e4e6f008a05928d9e06ff71f0ee26e0c4cfc5e97724e6cb"
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
