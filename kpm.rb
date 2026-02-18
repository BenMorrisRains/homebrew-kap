class Kpm < Formula
  desc "Kotlin Package Manager - Scaffold and manage Kotlin/Android projects and dependencies with ease."
  homepage "https://github.com/BenMorrisRains/Kotlin-Package-Manager"
  url "https://github.com/BenMorrisRains/Kotlin-Package-Manager/archive/v1.1.3.tar.gz"
  sha256 "6cc83ed937224847889228dec4ed4b3ba1425ef9dc047102135ece6c32c267b5"
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
