class Kpm < Formula
  desc "Kotlin Package Manager - Scaffold and manage Kotlin/Android projects and dependencies with ease."
  homepage "https://github.com/BenMorrisRains/Kotlin-Package-Manager"
  url "https://github.com/BenMorrisRains/Kotlin-Package-Manager/archive/v1.0.13.tar.gz"
  sha256 "5a6af0ae10341cdfb884c830a77131eaca43c33dfeb64868caa824941a99ae98"
  license "MIT"

  depends_on "gradle"
  depends_on "openjdk@17"

  def install
    # Set JAVA_HOME to use the correct Java version
    ENV["JAVA_HOME"] = Formula["openjdk@17"].opt_prefix
    
    # Download Gradle wrapper if missing
    unless File.exist?("gradle/wrapper/gradle-wrapper.jar")
      system "gradle", "wrapper", "--gradle-version=8.5"
    end
    
    system "./gradlew", "installDist"
    
    # Install the distribution
    libexec.install Dir["build/install/kpm/*"]
    
    # Create a wrapper script
    (bin/"kpm").write_env_script libexec/"bin/kpm", JAVA_HOME: Formula["openjdk@17"].opt_prefix
  end

  test do
    system "#{bin}/kpm", "--help"
  end
end
