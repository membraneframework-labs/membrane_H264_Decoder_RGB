defmodule Membrane.H264_RGB.Decoder do
  @moduledoc """
  This bin takes H264 video, decodes into raw video, scales to desired resolution and converts pixel format to RGB.
  """
  use Membrane.Bin

  alias Membrane.FFmpeg.SWScale.PixelFormatConverter, as: PixelFormatConverter
  alias Membrane.FFmpeg.SWScale.Scaler, as: Scaler
  alias Membrane.H264
  alias Membrane.RawVideo

  def_input_pad :input,
    accepted_format: H264,
    availability: :always

  def_output_pad :output,
    accepted_format: RawVideo,
    availability: :always

    def_options resolution: [
      spec: %{width: non_neg_integer(), height: non_neg_integer()} | :native,
      default: :native,
      description:
        "Desired output resolution."
    ]

  @impl true
  def handle_init(_ctx, options) do
    structure = if options.resolution == :native do
      bin_input()
      |> child(:decoder, Membrane.H264.FFmpeg.Decoder)
      |> child(:converter, %PixelFormatConverter{format: :RGB})
      |> bin_output()
    else
      bin_input()
      |> child(:decoder, Membrane.H264.FFmpeg.Decoder)
      |> child(:scaler, %Scaler{output_width: options.resolution.width, output_height: options.resolution.height})
      |> child(:converter, %PixelFormatConverter{format: :RGB})
      |> bin_output()
    end

    {[spec: structure], %{}}
  end
end
