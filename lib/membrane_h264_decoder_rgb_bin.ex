defmodule Membrane.H264_RGB.Decoder do
  @moduledoc """
  This bin takes H264 video, decodes into raw video and converts pixel format to RGB.
  """
  use Membrane.Bin

  alias Membrane.FFmpeg.SWScale.PixelFormatConverter, as: PixelFormatConverter
  alias Membrane.H264
  alias Membrane.RawVideo

  def_input_pad :input,
    accepted_format: H264,
    availability: :always

  def_output_pad :output,
    accepted_format: RawVideo,
    availability: :always

  @impl true
  def handle_init(_ctx, _options) do
    structure = [
      bin_input()
      |> child(:decoder, Membrane.H264.FFmpeg.Decoder)
      |> child(:converter, %PixelFormatConverter{format: :RGB})
      |> bin_output()
    ]

    {[spec: structure], %{}}
  end
end
