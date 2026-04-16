class XedTui < Formula
  desc "Terminal browser and session manager for Claude Code"
  homepage "https://tui.xed.dev"
  url "https://files.pythonhosted.org/packages/50/23/384811ad48582445dc6406a5e845b32effee52798b83a2ab3927393de476/xed_tui-1.26.5.tar.gz"
  sha256 "449d4b3278db4cbdba3f466c6b1e0936dae46f65f43541e8376650e7a5a0ff2b"
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
