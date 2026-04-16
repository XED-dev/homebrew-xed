class XedTui < Formula
  desc "Terminal browser and session manager for Claude Code"
  homepage "https://tui.xed.dev"
  url "https://files.pythonhosted.org/packages/98/0a/31b8250fddd93046154f729d67b093b13bbc6b18185227b058935e556a70/xed_tui-1.26.4.tar.gz"
  sha256 "2c525e2c65270d4bae3ec1fd780b68f1ee9444ca924a1fb36f3e60dc4e5dae9e"
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
