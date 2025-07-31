class GoLinksAT0 < Formula
  desc "URL aliasing service, with support for template parameters"
  homepage "https://github.com/egoodhall/go-links"
  url "https://github.com/egoodhall/go-links.git", tag: "v0.1.0"
  license ""
  head "https://github.com/egoodhall/go-links.git", branch: "main"

  depends_on "go" => :build

  # Additional dependency
  # resource "" do
  #   url ""
  #   sha256 ""
  # end

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w", output: bin/"go-links"), "./cmd/go-links"
  end

  test do
    system bin/"go-links", "-h"
  end
end
