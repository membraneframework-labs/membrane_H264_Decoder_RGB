defmodule Discarder do
  use Membrane.Filter

  def_input_pad :input, accepted_format: _any
  def_output_pad :output, accepted_format: _any

  def_options discard_ratio: [required?: true]

  @impl true
  def handle_init(_ctx, opts) do
    {[], %{all: 0, discarded: 0, target_ratio: opts.discard_ratio}}
  end

  @impl true
  def handle_buffer(:input, buffer, _ctx, state) do
    if discard?(state) do
      state = %{state | all: state.all + 1, discarded: state.discarded + 1}
      {[], state}
    else
      state = %{state | all: state.all + 1}
      {[buffer: {:output, buffer}], state}
    end
  end

  defp discard?(%{all: 0}), do: false

  defp discard?(state) do
    state.discarded / state.all < state.target_ratio
  end
end
