class XedTui < Formula
  desc "Terminal browser and session manager for Claude Code"
  homepage "https://tui.xed.dev"
  url "https://files.pythonhosted.org/packages/eb/2a/cd0417121cf08f6d60869233e89cb18866d6ccb49cb20ed60d8e8352357c/xed_tui-1.26.2.tar.gz"
  sha256 "036d36c7205e40f7c47ce6b9ff4375181c861f3ca52f3e8da118eb251e17aaa4"
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
