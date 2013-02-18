module WaveFileIOTestHelper
  CHANNEL_ALIAS = { :mono => 1, :stereo => 2, :tri => 3}

  SQUARE_WAVE_CYCLE = {}
  SQUARE_WAVE_CYCLE[:mono] = {}

  SQUARE_WAVE_CYCLE[:mono][:pcm_8] =    [88, 88, 88, 88, 167, 167, 167, 167]
  SQUARE_WAVE_CYCLE[:mono][:pcm_16] =   [-10000, -10000, -10000, -10000, 10000, 10000, 10000, 10000]
  SQUARE_WAVE_CYCLE[:mono][:pcm_32] =   [-1000000000, -1000000000, -1000000000, -1000000000,
                                          1000000000, 1000000000, 1000000000, 1000000000]
  SQUARE_WAVE_CYCLE[:mono][:float_32] = [-0.5, -0.5, -0.5, -0.5, 0.5, 0.5, 0.5, 0.5]
  SQUARE_WAVE_CYCLE[:mono][:float_64] = SQUARE_WAVE_CYCLE[:mono][:float_32]

  SQUARE_WAVE_CYCLE[:stereo] = {}
  SQUARE_WAVE_CYCLE[:stereo][:pcm_8] =  [[88, 88], [88, 88], [88, 88], [88, 88],
                                         [167, 167], [167, 167], [167, 167], [167, 167]]
  SQUARE_WAVE_CYCLE[:stereo][:pcm_16] = [[-10000, -10000], [-10000, -10000], [-10000, -10000], [-10000, -10000],
                                         [10000, 10000], [10000, 10000], [10000, 10000], [10000, 10000]]
  SQUARE_WAVE_CYCLE[:stereo][:pcm_32] = [[-1000000000, -1000000000], [-1000000000, -1000000000],
                                         [-1000000000, -1000000000], [-1000000000, -1000000000],
                                         [ 1000000000,  1000000000], [ 1000000000,  1000000000],
                                         [ 1000000000,  1000000000], [ 1000000000,  1000000000]]
  SQUARE_WAVE_CYCLE[:stereo][:float_32] = [[-0.5, -0.5], [-0.5, -0.5], [-0.5, -0.5], [-0.5, -0.5],
                                         [0.5, 0.5], [0.5, 0.5], [0.5, 0.5], [0.5, 0.5]]
  SQUARE_WAVE_CYCLE[:stereo][:float_64] = SQUARE_WAVE_CYCLE[:stereo][:float_32]

  SQUARE_WAVE_CYCLE[:tri] = {}
  SQUARE_WAVE_CYCLE[:tri][:pcm_8] =    [[88, 88, 88], [88, 88, 88], [88, 88, 88], [88, 88, 88],
                                    [167, 167, 167], [167, 167, 167], [167, 167, 167], [167, 167, 167]]
  SQUARE_WAVE_CYCLE[:tri][:pcm_16] =   [[-10000, -10000, -10000], [-10000, -10000, -10000],
                                        [-10000, -10000, -10000], [-10000, -10000, -10000],
                                        [ 10000,  10000,  10000], [ 10000,  10000,  10000],
                                        [ 10000,  10000,  10000], [ 10000,  10000,  10000]]
  SQUARE_WAVE_CYCLE[:tri][:pcm_32] =   [[-1000000000, -1000000000, -1000000000],
                                        [-1000000000, -1000000000, -1000000000],
                                        [-1000000000, -1000000000, -1000000000],
                                        [-1000000000, -1000000000, -1000000000],
                                        [ 1000000000,  1000000000,  1000000000],
                                        [ 1000000000,  1000000000,  1000000000],
                                        [ 1000000000,  1000000000,  1000000000],
                                        [ 1000000000,  1000000000,  1000000000]]
  SQUARE_WAVE_CYCLE[:tri][:float_32] = [[-0.5, -0.5, -0.5], [-0.5, -0.5, -0.5], [-0.5, -0.5, -0.5], [-0.5, -0.5, -0.5],
                                        [0.5, 0.5, 0.5], [0.5, 0.5, 0.5], [0.5, 0.5, 0.5], [0.5, 0.5, 0.5]]
  SQUARE_WAVE_CYCLE[:tri][:float_64] = SQUARE_WAVE_CYCLE[:tri][:float_32]


  # Executes the given block against different combinations of number of channels and sample_format
  def exhaustively_test
    [:mono, :stereo, :tri].each do |channels|
      [:pcm].each do |sample_format|
        Format::SUPPORTED_BITS_PER_SAMPLE[sample_format].each do |bits_per_sample|
          yield(channels, "#{sample_format}_#{bits_per_sample}".to_sym)
        end
      end
    end
  end

  # Executes the given block against different combinations of number of channels and sample_format
  # This exists temporarily until Reader supports reading floating point sample data, to prevent
  # those tests from breaking.
  def exhaustively_test_for_writer
    [:mono, :stereo, :tri].each do |channels|
      [:pcm, :float].each do |sample_format|
        Format::SUPPORTED_BITS_PER_SAMPLE[sample_format].each do |bits_per_sample|
          yield(channels, "#{sample_format}_#{bits_per_sample}".to_sym)
        end
      end
    end
  end
end
