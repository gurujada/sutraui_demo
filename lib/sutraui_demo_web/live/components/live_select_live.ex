defmodule SutrauiDemoWeb.Components.LiveSelectLive do
  use SutrauiDemoWeb, :live_view

  @countries [
    %{value: "us", label: "United States"},
    %{value: "ca", label: "Canada"},
    %{value: "mx", label: "Mexico"},
    %{value: "uk", label: "United Kingdom"},
    %{value: "de", label: "Germany"},
    %{value: "fr", label: "France"},
    %{value: "es", label: "Spain"},
    %{value: "it", label: "Italy"},
    %{value: "jp", label: "Japan"},
    %{value: "au", label: "Australia"}
  ]

  @tags [
    %{value: "elixir", label: "Elixir"},
    %{value: "phoenix", label: "Phoenix"},
    %{value: "liveview", label: "LiveView"},
    %{value: "tailwind", label: "Tailwind CSS"},
    %{value: "postgres", label: "PostgreSQL"},
    %{value: "ecto", label: "Ecto"}
  ]

  def mount(_params, _session, socket) do
    form = to_form(%{"country" => nil, "tags" => [], "skills" => []})

    {:ok,
     assign(socket,
       page_title: "Live Select",
       form: form,
       countries: @countries,
       tags: @tags
     )}
  end

  def handle_event("live_select_change", %{"id" => id, "text" => text}, socket) do
    options =
      case id do
        "country-select" -> filter_options(@countries, text)
        "tags-select" -> filter_options(@tags, text)
        "skills-select" -> filter_options(@tags, text)
        "clearable-select" -> filter_options(@countries, text)
        "disabled-select" -> filter_options(@countries, text)
        _ -> []
      end

    send_update(SutraUI.LiveSelect, id: id, options: options)
    {:noreply, socket}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  defp filter_options(options, ""), do: options

  defp filter_options(options, text) do
    text = String.downcase(text)

    Enum.filter(options, fn opt ->
      String.contains?(String.downcase(opt.label), text)
    end)
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/live-select">
      <.docs_header
        title="Live Select"
        description="A searchable select component with support for single selection, tags, and async search."
      />

      <.component_demo title="Single Select" code={single_code()}>
        <div class="w-full max-w-sm">
          <.form for={@form} phx-change="validate">
            <.live_component
              module={SutraUI.LiveSelect}
              id="country-select"
              field={@form[:country]}
              placeholder="Select a country..."
              options={@countries}
            />
          </.form>
        </div>
      </.component_demo>

      <.section_heading id="tags-mode">Tags Mode</.section_heading>
      <.prose>
        Use
        <.inline_code>mode={:tags}</.inline_code>
        for multi-select with tag chips.
      </.prose>

      <.component_demo title="Tags Mode" code={tags_code()}>
        <div class="w-full max-w-sm">
          <.form for={@form} phx-change="validate">
            <.live_component
              module={SutraUI.LiveSelect}
              id="tags-select"
              field={@form[:tags]}
              mode={:tags}
              placeholder="Select technologies..."
              options={@tags}
            />
          </.form>
        </div>
      </.component_demo>

      <.section_heading id="quick-tags">Quick Tags Mode</.section_heading>
      <.prose>
        Use
        <.inline_code>mode={:quick_tags}</.inline_code>
        to allow selecting without clearing the search input.
      </.prose>

      <.component_demo title="Quick Tags" code={quick_tags_code()}>
        <div class="w-full max-w-sm">
          <.form for={@form} phx-change="validate">
            <.live_component
              module={SutraUI.LiveSelect}
              id="skills-select"
              field={@form[:skills]}
              mode={:quick_tags}
              placeholder="Add skills..."
              options={@tags}
            />
          </.form>
        </div>
      </.component_demo>

      <.section_heading id="allow-clear">Allow Clear</.section_heading>
      <.prose>
        Add a clear button with <.inline_code>allow_clear</.inline_code>.
      </.prose>

      <.component_demo title="Allow Clear" code={clear_code()}>
        <div class="w-full max-w-sm">
          <.form for={@form} phx-change="validate">
            <.live_component
              module={SutraUI.LiveSelect}
              id="clearable-select"
              field={@form[:country]}
              placeholder="Select a country..."
              options={@countries}
              allow_clear
            />
          </.form>
        </div>
      </.component_demo>

      <.section_heading id="async-search">Async Search</.section_heading>
      <.prose>
        Live Select sends
        <.inline_code>live_select_change</.inline_code>
        events for server-side filtering.
      </.prose>

      <.code_block language="elixir" code={async_code()} />

      <.section_heading id="custom-options">Custom Option Rendering</.section_heading>
      <.prose>
        Use the
        <.inline_code>option</.inline_code>
        slot to customize how options are displayed.
      </.prose>

      <.code_block language="heex" code={custom_option_code()} />

      <.section_heading id="max-selectable">Max Selectable</.section_heading>
      <.prose>
        Limit the number of selections in tags mode with <.inline_code>max_selectable</.inline_code>.
      </.prose>

      <.code_block language="heex" code={max_code()} />

      <.section_heading id="user-defined">User-Defined Options</.section_heading>
      <.prose>
        Allow users to create new options by setting <.inline_code>user_defined_options</.inline_code>.
      </.prose>

      <.code_block language="heex" code={user_defined_code()} />

      <.section_heading id="disabled">Disabled</.section_heading>
      <.prose>
        Use the disabled attribute to prevent interaction.
      </.prose>

      <.component_demo
        title="Disabled"
        code={~s|<.live_component module={SutraUI.LiveSelect} ... disabled />|}
      >
        <div class="w-full max-w-sm">
          <.form for={@form} phx-change="validate">
            <.live_component
              module={SutraUI.LiveSelect}
              id="disabled-select"
              field={@form[:country]}
              placeholder="Select a country..."
              options={@countries}
              disabled
            />
          </.form>
        </div>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp single_code do
    """
    <.live_component
      module={SutraUI.LiveSelect}
      id="country-select"
      field={@form[:country]}
      placeholder="Select a country..."
      options={@countries}
    />\
    """
  end

  defp tags_code do
    """
    <.live_component
      module={SutraUI.LiveSelect}
      id="tags-select"
      field={@form[:tags]}
      mode={:tags}
      placeholder="Select technologies..."
      options={@tags}
    />\
    """
  end

  defp quick_tags_code do
    """
    <.live_component
      module={SutraUI.LiveSelect}
      id="skills-select"
      field={@form[:skills]}
      mode={:quick_tags}
      placeholder="Add skills..."
      options={@tags}
    />\
    """
  end

  defp clear_code do
    """
    <.live_component
      module={SutraUI.LiveSelect}
      id="clearable-select"
      field={@form[:country]}
      placeholder="Select a country..."
      options={@countries}
      allow_clear
    />\
    """
  end

  defp async_code do
    """
    def handle_event("live_select_change", %{"id" => id, "text" => text}, socket) do
      # Fetch options from database or API
      options = search_countries(text)

      # Update the LiveSelect component with new options
      send_update(SutraUI.LiveSelect, id: id, options: options)

      {:noreply, socket}
    end\
    """
  end

  defp custom_option_code do
    """
    <.live_component module={SutraUI.LiveSelect} id="user-select" field={@form[:user]} options={@users}>
      <:option :let={option}>
        <div class="flex items-center gap-2">
          <img src={option.avatar} class="w-6 h-6 rounded-full" />
          <span>{option.label}</span>
        </div>
      </:option>
    </.live_component>\
    """
  end

  defp max_code do
    """
    <.live_component
      module={SutraUI.LiveSelect}
      id="tags-select"
      field={@form[:tags]}
      mode={:tags}
      max_selectable={3}
      options={@tags}
    />\
    """
  end

  defp user_defined_code do
    """
    <.live_component
      module={SutraUI.LiveSelect}
      id="tags-select"
      field={@form[:tags]}
      mode={:tags}
      user_defined_options
      options={@tags}
    />\
    """
  end
end
