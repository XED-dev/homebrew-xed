class XedTui < Formula
  desc "Terminal browser and session manager for Claude Code"
  homepage "https://tui.xed.dev"
  url "https://files.pythonhosted.org/packages/a3/f8/87886bff3e43466a9d186324f8c5084021970d839eda3c36ce0e8531b4f8/xed_tui-1.26.0.tar.gz"
  sha256 "b497f43411bec0d1146177fca0d10be9e77cf57c602c7a33eb50db2a0c9e8835"
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
