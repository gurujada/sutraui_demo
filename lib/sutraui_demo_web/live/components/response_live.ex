defmodule SutrauiDemoWeb.Components.ResponseLive do
  use SutrauiDemoWeb, :live_view

  @stream_chunks [
    "Sutra UI keeps the rendering primitive small: ",
    "the parent LiveView owns the stream, ",
    "and the response renders the text safely as it arrives."
  ]

  @markdown_response """
  The same primitive can render:

  - streamed prose
  - partial **Markdown**
  - sanitized model output

  ```elixir
  <.response value={@answer} format="markdown" streaming />
  ```
  """

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(page_title: "Response")
      |> assign(:stream_run_id, nil)
      |> assign(:reveal_run_id, nil)
      |> assign(:markdown_run_id, nil)
      |> assign_response_stream(:stream, 0)
      |> assign_response_stream(:reveal, 0)
      |> assign_response_stream(:markdown, 0)

    socket =
      if connected?(socket) do
        socket
        |> start_response_stream(:stream)
        |> start_response_stream(:reveal)
        |> start_response_stream(:markdown)
      else
        socket
      end

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/response">
      <.docs_header
        title="Response"
        description="Render model output as plain text or streamed Markdown with MDEx-backed sanitization."
      />

      <.component_demo title="Streaming Text" code={streaming_code()}>
        <div class="grid w-full max-w-lg gap-4">
          <div class="rounded-lg border bg-card p-4 shadow-xs">
            <.response
              id="response-stream"
              value={@stream_value}
              streaming={@stream_streaming}
              reveal="word"
              class="text-sm leading-7"
            />
          </div>
          <.button type="button" size="sm" variant="outline" phx-click="replay_stream">
            Replay
          </.button>
        </div>
      </.component_demo>

      <.section_heading id="reveal">Reveal Styles</.section_heading>
      <.prose>
        Use
        <.inline_code>reveal</.inline_code>
        to choose how newly received text appears. The parent LiveView still
        owns the stream and marks it done with <.inline_code>streaming={false}</.inline_code>. Reveal styles use a
        small hook to smooth text that has already arrived.
      </.prose>

      <.component_demo title="Reveal Styles" code={reveal_code()}>
        <div class="grid w-full max-w-lg gap-3">
          <div class="rounded-lg border bg-card p-4 shadow-xs">
            <p class="mb-2 text-xs font-medium text-muted-foreground">Chunk</p>
            <.response id="response-chunk" value={@reveal_value} streaming={@reveal_streaming} />
          </div>
          <div class="rounded-lg border bg-card p-4 shadow-xs">
            <p class="mb-2 text-xs font-medium text-muted-foreground">Word</p>
            <.response
              id="response-word"
              value={@reveal_value}
              streaming={@reveal_streaming}
              reveal="word"
            />
          </div>
          <div class="rounded-lg border bg-card p-4 shadow-xs">
            <p class="mb-2 text-xs font-medium text-muted-foreground">Character</p>
            <.response
              id="response-character"
              value={@reveal_value}
              streaming={@reveal_streaming}
              reveal="character"
            />
          </div>
          <.button type="button" size="sm" variant="outline" phx-click="replay_reveal">
            Replay
          </.button>
        </div>
      </.component_demo>

      <.section_heading id="markdown">Markdown</.section_heading>
      <.prose>
        Set
        <.inline_code>format="markdown"</.inline_code>
        for Markdown. Stream the value from the parent LiveView; the component
        re-renders sanitized Markdown as each word arrives.
      </.prose>

      <.component_demo title="Markdown" code={markdown_code()}>
        <div class="grid w-full max-w-lg gap-4">
          <div class="rounded-lg border bg-card p-4 shadow-xs">
            <.response
              id="response-markdown"
              value={@markdown_value}
              format="markdown"
              streaming={@markdown_streaming}
            />
          </div>
          <.button type="button" size="sm" variant="outline" phx-click="replay_markdown">
            Replay
          </.button>
        </div>
      </.component_demo>
    </Layouts.docs>
    """
  end

  def handle_info({:response_tick, kind, run_id}, socket) do
    run_id_key = response_key(kind, :run_id)

    if socket.assigns[run_id_key] == run_id do
      index_key = response_key(kind, :index)
      streaming_key = response_key(kind, :streaming)
      next_index = min(socket.assigns[index_key] + 1, length(chunks_for(kind)))
      socket = assign_response_stream(socket, kind, next_index)

      if socket.assigns[streaming_key], do: schedule_tick(kind, run_id)

      {:noreply, socket}
    else
      {:noreply, socket}
    end
  end

  def handle_event("replay_stream", _params, socket) do
    {:noreply, start_response_stream(socket, :stream)}
  end

  def handle_event("replay_reveal", _params, socket) do
    {:noreply, start_response_stream(socket, :reveal)}
  end

  def handle_event("replay_markdown", _params, socket) do
    {:noreply, start_response_stream(socket, :markdown)}
  end

  defp start_response_stream(socket, kind) when kind in [:stream, :reveal, :markdown] do
    run_id = System.unique_integer([:positive])
    schedule_tick(kind, run_id)

    socket
    |> assign(response_key(kind, :run_id), run_id)
    |> assign_response_stream(kind, 0)
  end

  defp assign_response_stream(socket, kind, index) when kind in [:stream, :reveal, :markdown] do
    chunks = chunks_for(kind)

    socket
    |> assign(response_key(kind, :index), index)
    |> assign(response_key(kind, :streaming), index < length(chunks))
    |> assign(response_key(kind, :value), chunks |> Enum.take(index) |> Enum.join())
  end

  defp chunks_for(:stream), do: @stream_chunks
  defp chunks_for(:reveal), do: @stream_chunks

  defp chunks_for(:markdown) do
    Regex.scan(~r/\S+\s*/, @markdown_response)
    |> List.flatten()
  end

  defp response_key(:stream, :run_id), do: :stream_run_id
  defp response_key(:stream, :index), do: :stream_index
  defp response_key(:stream, :streaming), do: :stream_streaming
  defp response_key(:stream, :value), do: :stream_value
  defp response_key(:reveal, :run_id), do: :reveal_run_id
  defp response_key(:reveal, :index), do: :reveal_index
  defp response_key(:reveal, :streaming), do: :reveal_streaming
  defp response_key(:reveal, :value), do: :reveal_value
  defp response_key(:markdown, :run_id), do: :markdown_run_id
  defp response_key(:markdown, :index), do: :markdown_index
  defp response_key(:markdown, :streaming), do: :markdown_streaming
  defp response_key(:markdown, :value), do: :markdown_value

  defp schedule_tick(kind, run_id) do
    Process.send_after(self(), {:response_tick, kind, run_id}, tick_delay(kind))
  end

  defp tick_delay(:markdown), do: 120
  defp tick_delay(_kind), do: 550

  defp streaming_code do
    """
    <.response
      id="response-stream"
      value={@stream_value}
      streaming={@stream_streaming}
      reveal="word"
    />\
    """
  end

  defp reveal_code do
    """
    <.response value={@reveal_value} streaming={@reveal_streaming} />
    <.response id="response-word" value={@reveal_value} streaming={@reveal_streaming} reveal="word" />
    <.response id="response-character" value={@reveal_value} streaming={@reveal_streaming} reveal="character" />\
    """
  end

  defp markdown_code do
    """
    <.response
      id="response-markdown"
      value={@markdown_value}
      format="markdown"
      streaming={@markdown_streaming}
    />\
    """
  end
end
