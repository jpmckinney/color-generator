class ColorGenerator
  GOLDEN_RATIO_CONJUGATE = 0.618033988749895

  attr_reader :hue, :saturation, :value

  # Initializes a color generator.
  #
  # @param [Float,Integer] saturation saturation in the interval [0, 1]
  # @param [Float,Integer] value value in the interval [0, 1]
  def initialize(saturation, value)
    @hue        = rand
    @saturation = saturation.to_f
    @value      = value.to_f
  end

  # Generates a random color.
  #
  # @return [String] an RGB hex triplet
  def create
    @hue += GOLDEN_RATIO_CONJUGATE
    @hue %= 1
    '%02x%02x%02x' % self.class.rgb_from_hsv(hue, saturation, value)
  end

  # Converts a color from HSV to RGB.
  #
  # @param [Float] h hue in the interval [0, 1]
  # @param [Float] s saturation in the interval [0, 1]
  # @param [Float] v value in the interval [0, 1]
  # @return [Array] an RGB decimal triplet
  #
  # @see http://en.wikipedia.org/wiki/HSL_and_HSV#Converting_to_RGB
  def self.rgb_from_hsv(h, s, v)
    c = v * s
    m = v - c
    h_prime = h * 6
    x_prime = v - c * (h_prime % 2 - 1).abs

    # Unlike the Wikipedia article, we add m right away. This reduces the
    # number of operations to perform. For example, for H' < 1:
    #
    # R = R1 + m
    # R = C + m
    # R = C + V - C
    # R = V
    #
    # G = G1 + m
    # G = X + m
    # G = C (1 - |H' mod 2 - 1|) + m
    # G = C (1 - |H' mod 2 - 1|) + V - C
    # G = C - C |H' mod 2 - 1| + V - C
    # G = V - C |H' mod 2 - 1|
    #
    # B = B1 + m
    # B = 0 + m
    # B = m
    #
    # The blog post above calculates two X values, for when H' mod 2 is
    # greater or less than 1.
    case h_prime.to_i
    when 0 # 0 <= H' < 1
      [v, x_prime, m]
    when 1 # 1 <= H' < 2
      [x_prime, v, m]
    when 2 # 2 <= H' < 3
      [m, v, x_prime]
    when 3 # 3 <= H' < 4
      [m, x_prime, v]
    when 4 # 4 <= H' < 5
      [x_prime, m, v]
    else # 5 <= H' < 6
      [v, m, x_prime]
    end.map{|value| (value * 255).round}
  end
end
