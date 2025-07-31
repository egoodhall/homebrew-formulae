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

  def post_install
    # Create config directory
    config_dir = etc/"go-links"
    config_dir.mkpath

    # Create default config file if it doesn't exist
    config_file = config_dir/"config.yaml"
    unless config_file.exist?
      config_file.write <<~EOS
        # Go-links configuration
        # Add your URL aliases below
        address: ":8080"
        targets: []
      EOS
    end
  end

  test do
    system bin/"go-links", "-h"
  end

  service do
    run [bin/"go-links", "-c", etc/"go-links/config.yaml"]
  end

  def caveats
    <<~EOS
      A default configuration file has been created at:
        #{etc}/go-links/config.yaml

      You can edit this file to add your URL aliases.
      The service will automatically use this configuration file.
    EOS
  end
end
