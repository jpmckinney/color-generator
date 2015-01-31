class ColorGenerator
  GOLDEN_RATIO_CONJUGATE = 0.618033988749895

  attr_reader :mode, :hue, :saturation, :lightness, :value

  # Initializes a color generator.
  #
  # @param [Hash] opts optional arguments
  # @option opts [Float,Integer] :saturation saturation in the interval [0, 1]
  # @option opts [Float,Integer] :lightness lightness in the interval [0, 1],
  #   sets the color representation to HSL
  # @option opts [Float,Integer] :value value in the interval [0, 1], sets the
  #   color representation to HSV
  # @option opts [Integer] :seed seed for the pseudorandom number generator
  # @option opts [Float,Integer] :hue hue to use as the start in the interval [0, 1]
  def initialize(opts = {})
    if opts.key?(:hue)
      @hue = opts[:hue]
    else
      srand(opts[:seed]) if opts.key?(:seed)
      @hue = rand
    end
    @saturation = opts[:saturation].to_f
    if opts.has_key? :lightness
      @mode = :HSL
      @lightness = opts[:lightness].to_f
    else
      @mode = :HSV
      @value = opts[:value].to_f
    end
  end

  # Formats a random color as an RGB hex triplet.
  #
  # @return [String] an RGB hex triplet
  def create_hex
    '%02x%02x%02x' % create_rgb
  end

  # For backwards compatibility.
  alias_method :create, :create_hex

  # Generates a random color as an RGB decimal triplet.
  #
  # @return [Array] an RGB decimal triplet
  def create_rgb
    @hue = (hue + GOLDEN_RATIO_CONJUGATE) % 1
    if hsl?
      self.class.rgb_from_hsl hue, saturation, lightness
    else
      self.class.rgb_from_hsv hue, saturation, value
    end
  end

  # @return [Boolean] whether the color representation is HSL
  def hsl?
    mode == :HSL
  end

  # @return [Boolean] whether the color representation is HSV
  def hsv?
    mode == :HSV
  end

  # Converts a color from HSL to RGB.
  #
  # @param [Float] h hue in the interval [0, 1]
  # @param [Float] s saturation in the interval [0, 1]
  # @param [Float] l lightness in the interval [0, 1]
  # @return [Array] an RGB decimal triplet
  def self.rgb_from_hsl(h, s, l)
    c = (1 - (2 * l - 1).abs) * s
    m = l - 0.5 * c
    rgb_from_hsl_or_hsv h, c, m
  end

  # Converts a color from HSV to RGB.
  #
  # @param [Float] h hue in the interval [0, 1]
  # @param [Float] s saturation in the interval [0, 1]
  # @param [Float] v value in the interval [0, 1]
  # @return [Array] an RGB decimal triplet
  def self.rgb_from_hsv(h, s, v)
    c = v * s
    m = v - c
    rgb_from_hsl_or_hsv h, c, m
  end

private

  # @param [Float] h hue in the interval [0, 1]
  # @param [Float] c chroma
  # @param [Float] m
  # @return [Array] an RGB decimal triplet
  #
  # @see https://en.wikipedia.org/wiki/HSL_and_HSV#Converting_to_RGB
  def self.rgb_from_hsl_or_hsv(h, c, m)
    h_prime = h * 6
    x = c * (1 - (h_prime % 2 - 1).abs)

    case h_prime.to_i
    when 0 # 0 <= H' < 1
      [c, x, 0]
    when 1 # 1 <= H' < 2
      [x, c, 0]
    when 2 # 2 <= H' < 3
      [0, c, x]
    when 3 # 3 <= H' < 4
      [0, x, c]
    when 4 # 4 <= H' < 5
      [x, 0, c]
    else # 5 <= H' < 6
      [c, 0, x]
    end.map{|value| ((value + m) * 255).round}
  end
end
