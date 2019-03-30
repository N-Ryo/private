class Sample

  def pub
    "Hello from Public."
  end

  def test
    puts pro
    puts pri
  end

  def test2(other)
    puts "#{other.pro} と #{pro}"
    puts "#{other.pri} と #{pri}"
  end

  protected

    def pro
      "Hello from Protected."
    end

  private
    def pri
      "Hello from Priavte"
    end
end

sample_1 = Sample.new
sample_2 = Sample.new

sample_2.test2(sample_1)