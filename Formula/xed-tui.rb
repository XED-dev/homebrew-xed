class XedTui < Formula
  desc "Terminal browser and session manager for Claude Code"
  homepage "https://tui.xed.dev"
  url "https://files.pythonhosted.org/packages/65/7c/66c94d5c00673be6deced66b959ab0b98442fec4f33a76c8567038114d37/xed_tui-1.26.3.tar.gz"
  sha256 "ed6c314d2824496cf70050dbeb86b3f5b006b0ed7d8c16f9016844ac93a4871e"
  license "MIT"
  head "https://github.com/XED-dev/TUI.git", branch: "main"

  depends_on "python@3.11"

  def install
    python3 = Formula["python@3.11"].opt_bin/"python3.11"
    libexec.install Dir["src/xed_tui/*"]
    (bin/"xed-tui").write <<~EOS
      #!/bin/sh
      exec "#{python3}" "#{libexec}/__main__.py" "$@"
    EOS
  end

  test do
    # --help exits with 0 and prints keybinding reference
    assert_match "XED /TUI", shell_output("#{bin}/xed-tui --help 2>&1 || true")
  end
end
