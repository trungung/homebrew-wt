class Wt < Formula
  desc "Fast, branch-centric git worktree manager"
  homepage "https://github.com/trungung/wt"
  url "https://github.com/trungung/wt/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "053657250b2de8b850565b0dacda0cd2369a045b38b6c6af1096896d0b637e15"
  license "MIT"
  head "https://github.com/trungung/wt.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}"), "./cmd/wt"

    zsh_completion.install buildpath/"cmd/wt/_wt"
  end

  test do
    system "git", "init"
    assert_includes shell_output("#{bin}/wt --help"), "fast, branch-addressable git worktree manager"
    assert_match version.to_s, shell_output("#{bin}/wt --version")
  end
end
