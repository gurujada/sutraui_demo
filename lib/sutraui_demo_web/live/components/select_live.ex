defmodule SutrauiDemoWeb.Components.SelectLive do
  use SutrauiDemoWeb, :live_view

  @roles [
    {"Admin", "admin"},
    {"Teacher", "teacher"},
    {"Learner", "learner"},
    {"Observer", "observer", disabled: true}
  ]

  @countries ~w(Argentina Australia Bangladesh Brazil Canada Chile Egypt France Germany India Indonesia Japan Kenya Mexico Nepal Nigeria Pakistan Singapore Sri\ Lanka Vietnam)

  @stacks [
    {"Backend",
     [{"Phoenix", "phoenix"}, {"Rails", "rails", disabled: true}, {"Django", "django"}]},
    {"Frontend", [{"React", "react"}, {"Vue", "vue"}, {"Svelte", "svelte"}]}
  ]

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(page_title: "Select", roles: @roles, countries: @countries, stacks: @stacks)
     |> assign(form: to_form(%{"role" => "", "tags" => []}, as: :invite))
     |> assign(show_dialog: false, saved: nil, status: "active")}
  end

  def handle_event("validate", %{"invite" => params}, socket) do
    {:noreply, assign(socket, :form, invite_form(params))}
  end

  def handle_event("save", %{"invite" => params}, socket) do
    form = invite_form(params)

    if form.errors == [] do
      SutraUI.Toast.send(:success, "Invited #{params["email"]} as #{params["role"]}")
      {:noreply, assign(socket, form: form, saved: params)}
    else
      {:noreply, assign(socket, form: form)}
    end
  end

  def handle_event("open_dialog", _params, socket),
    do: {:noreply, assign(socket, :show_dialog, true)}

  def handle_event("close_dialog", _params, socket),
    do: {:noreply, assign(socket, :show_dialog, false)}

  def handle_event("dialog_save", %{"team" => team}, socket) do
    SutraUI.Toast.send(:success, "Team set to #{team["country"]}")
    {:noreply, assign(socket, :show_dialog, false)}
  end

  def handle_event("set_status", %{"status" => status}, socket) do
    {:noreply, assign(socket, :status, status)}
  end

  def handle_event(_event, _params, socket), do: {:noreply, socket}

  defp invite_form(params) do
    params = Map.put_new(params, "tags", [])

    errors =
      []
      |> add_error(params["role"] in [nil, ""], :role, "Choose a role")
      |> add_error(params["tags"] == [], :tags, "Pick at least one subject")

    to_form(params, as: :invite, errors: errors)
  end

  defp add_error(errors, true, field, message), do: [{field, {message, []}} | errors]
  defp add_error(errors, false, _field, _message), do: errors

  def render(assigns) do
    ~H"""
    <Layouts.docs
      flash={@flash}
      sutra_commands={@sutra_commands}
      current_path="/docs/components/select"
    >
      <.docs_header
        title="Select"
        description="A real select underneath, with SutraUI's own list on top: forms, validation and first paint work without JavaScript."
      />

      <.callout>
        The server renders a real
        <.inline_code>&lt;select&gt;</.inline_code>
        with the options. The extracted hook hides it and shows a trigger and a list drawn as page markup, so the open list also appears in a screen share. Below 640 px the list is a bottom sheet.
      </.callout>

      <.component_demo
        title="Options and a prompt"
        code={basic_code()}
        class="[&_.demo-preview]:min-h-[240px] [&_.demo-preview]:items-start [&_.demo-preview]:pt-4"
      >
        <div class="w-full max-w-xs">
          <.select
            id="basic-select"
            name="role"
            label="Role"
            prompt="Choose a role"
            options={@roles}
          />
        </div>
      </.component_demo>

      <.section_heading id="form">In a form, with errors</.section_heading>
      <.prose>
        <.inline_code>&lt;.input type="select"&gt;</.inline_code>
        renders the select with its label, description and errors. Errors appear once a field is used (<.inline_code>used_input?</.inline_code>),
        and
        <.inline_code>aria-invalid</.inline_code>
        goes to the trigger.
      </.prose>

      <.component_demo
        title="Form with validation"
        code={form_code()}
        class="[&_.demo-preview]:min-h-[420px] [&_.demo-preview]:items-start [&_.demo-preview]:pt-4"
      >
        <.form
          for={@form}
          id="invite-form"
          phx-change="validate"
          phx-submit="save"
          class="w-full max-w-sm"
        >
          <.input field={@form[:email]} type="email" label="Email" placeholder="asha@example.com" />
          <.input
            field={@form[:role]}
            type="select"
            label="Role"
            description="What they can do in the workbook."
            prompt="Choose a role"
            options={@roles}
          />
          <.input
            field={@form[:tags]}
            type="select"
            label="Subjects"
            multiple
            options={["Physics", "Chemistry", "Mathematics", "Biology"]}
          />
          <.button type="submit">Send invite</.button>
        </.form>
        <p :if={@saved} id="invite-saved" class="mt-3 text-sm text-muted-foreground">
          Posted: {@saved["email"]}, role {@saved["role"]}, subjects {@saved["tags"]
          |> List.wrap()
          |> Enum.reject(&(&1 == ""))
          |> Enum.join(", ")}
        </p>
      </.component_demo>

      <.section_heading id="search">Search</.section_heading>
      <.prose>
        <.inline_code>searchable</.inline_code>
        defaults to <.inline_code>nil</.inline_code>: a search box appears from 10 options on. Force it with
        <.inline_code>true</.inline_code>
        or <.inline_code>false</.inline_code>. Letters type-ahead on the field; in the search box they filter.
      </.prose>

      <.component_demo
        title="Searchable (20 options)"
        code={search_code()}
        class="[&_.demo-preview]:min-h-[340px] [&_.demo-preview]:items-start [&_.demo-preview]:pt-4"
      >
        <div class="w-full max-w-xs">
          <.select
            id="country-select"
            name="country"
            label="Country"
            prompt="Choose a country"
            options={@countries}
          />
        </div>
      </.component_demo>

      <.section_heading id="groups">Groups and disabled options</.section_heading>
      <.component_demo
        title="Groups"
        code={groups_code()}
        class="[&_.demo-preview]:min-h-[340px] [&_.demo-preview]:items-start [&_.demo-preview]:pt-4"
      >
        <div class="w-full max-w-xs">
          <.select
            id="stack-select"
            name="stack"
            label="Stack"
            prompt="Choose a stack"
            options={@stacks}
          />
        </div>
      </.component_demo>

      <.section_heading id="multiple">Multiple</.section_heading>
      <.prose>
        <.inline_code>multiple</.inline_code>
        shows chips in the trigger and keeps the list open while choosing. A multiple select with nothing chosen posts nothing for its field (the browser's rule), so default it in the handler.
      </.prose>

      <.component_demo
        title="Multiple"
        code={multiple_code()}
        class="[&_.demo-preview]:min-h-[320px] [&_.demo-preview]:items-start [&_.demo-preview]:pt-4"
      >
        <div class="w-full max-w-sm">
          <.select
            id="multi-select"
            name="subjects[]"
            label="Subjects"
            multiple
            value={["Physics", "Mathematics"]}
            options={["Physics", "Chemistry", "Mathematics", "Biology"]}
          />
        </div>
      </.component_demo>

      <.section_heading id="native">Native</.section_heading>
      <.prose>
        <.inline_code>native</.inline_code>
        keeps only the browser's own select, for a page that must work without JavaScript.
      </.prose>

      <.component_demo title="Native" code={native_code()}>
        <div class="w-full max-w-xs">
          <.input
            type="select"
            id="native-select"
            name="lang"
            label="Language"
            native
            options={["English", "Hindi", "Telugu"]}
          />
        </div>
      </.component_demo>

      <.section_heading id="dialog">Inside a dialog</.section_heading>
      <.prose>
        The open list is a fixed card placed from the trigger, so a dialog body no longer clips it.
      </.prose>

      <.component_demo title="In a dialog" code={dialog_code()}>
        <.button id="open-select-dialog" variant="outline" phx-click="open_dialog">Choose a country</.button>
        <.dialog id="select-dialog" show={@show_dialog} on_cancel="close_dialog">
          <:title>Team location</:title>
          <:description>Pick the country the team works from.</:description>
          <.form for={%{}} as={:team} id="team-form" phx-submit="dialog_save">
            <.input
              type="select"
              id="dialog-country"
              name="team[country]"
              label="Country"
              prompt="Choose a country"
              options={@countries}
            />
            <div class="flex justify-end gap-2">
              <.button type="button" variant="outline" phx-click="close_dialog">Cancel</.button>
              <.button type="submit">Save</.button>
            </div>
          </.form>
        </.dialog>
      </.component_demo>

      <.section_heading id="custom">Custom option content</.section_heading>
      <.prose>
        For options that need markup (a badge, an icon) build the list with <.inline_code>select_option</.inline_code>.
        That form keeps a hidden
        <.inline_code>&lt;input&gt;</.inline_code>
        instead of a <.inline_code>&lt;select&gt;</.inline_code>.
        Prefer
        <.inline_code>options</.inline_code>
        wherever the options are plain text.
      </.prose>

      <.component_demo
        title="Custom options"
        code={custom_code()}
        class="[&_.demo-preview]:min-h-[220px] [&_.demo-preview]:items-start [&_.demo-preview]:pt-4"
      >
        <div class="w-[220px]">
          <.select id="status-select" name="status" value={@status} phx-change="set_status">
            <:trigger>
              <.badge variant={status_variant(@status)} appearance="soft">{@status}</.badge>
            </:trigger>
            <.select_option value="active" label="Active" />
            <.select_option value="pending" label="Pending" />
            <.select_option value="archived" label="Archived" />
          </.select>
        </div>
      </.component_demo>

      <.section_heading id="notes">Usage Notes</.section_heading>
      <.list>
        <.list_item>
          WAI-ARIA select-only combobox (editable with search) and listbox. Arrows, Home/End, PageUp/PageDown, type-ahead, Enter/Space, Tab and Escape all work.
        </.list_item>
        <.list_item>
          The list flips above the field or shifts to stay on screen and scrolls inside the room it has.
        </.list_item>
        <.list_item>
          Merge
          <.inline_code>phoenix-colocated/sutra_ui</.inline_code>
          into your LiveSocket so the styled list shows; without it the browser's own select works.
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  defp status_variant("active"), do: "success"
  defp status_variant("pending"), do: "warning"
  defp status_variant(_), do: "secondary"

  defp basic_code do
    """
    <.select id="role" name="role" label="Role" prompt="Choose a role" options={[
      {"Admin", "admin"},
      {"Teacher", "teacher"},
      {"Observer", "observer", disabled: true}
    ]} />\
    """
  end

  defp form_code do
    """
    <.form for={@form} phx-change="validate" phx-submit="save">
      <.input field={@form[:role]} type="select" label="Role"
              description="What they can do in the workbook."
              prompt="Choose a role" options={@roles} />
      <.input field={@form[:tags]} type="select" label="Subjects" multiple
              options={["Physics", "Chemistry", "Mathematics"]} />
    </.form>\
    """
  end

  defp search_code do
    """
    <%!-- a search box appears from 10 options; force it with searchable --%>
    <.select id="country" name="country" label="Country" prompt="Choose a country" options={@countries} />\
    """
  end

  defp groups_code do
    """
    <.select id="stack" name="stack" label="Stack" options={[
      {"Backend", [{"Phoenix", "phoenix"}, {"Rails", "rails", disabled: true}]},
      {"Frontend", [{"React", "react"}, {"Vue", "vue"}]}
    ]} />\
    """
  end

  defp multiple_code do
    """
    <.select id="subjects" name="subjects[]" label="Subjects" multiple
             value={["Physics", "Mathematics"]}
             options={["Physics", "Chemistry", "Mathematics", "Biology"]} />\
    """
  end

  defp native_code do
    """
    <.input type="select" name="lang" label="Language" native options={["English", "Hindi"]} />\
    """
  end

  defp dialog_code do
    """
    <.dialog id="team-dialog" show={@show} on_cancel="close">
      <.form for={%{}} as={:team} phx-submit="save">
        <.input type="select" name="team[country]" label="Country" options={@countries} />
      </.form>
    </.dialog>\
    """
  end

  defp custom_code do
    """
    <.select id="status" name="status" value={@status}>
      <:trigger><.badge>{@status}</.badge></:trigger>
      <.select_option value="active" label="Active" />
      <.select_option value="pending" label="Pending" />
    </.select>\
    """
  end
end
