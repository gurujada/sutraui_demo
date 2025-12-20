defmodule SutrauiDemoWeb.Components.SimpleFormLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Simple Form")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/simple-form">
      <.docs_header
        title="Simple Form"
        description="A form wrapper that automatically styles all child form elements without requiring explicit classes."
      />

      <.section_heading id="how-it-works">How It Works</.section_heading>
      <.prose>
        The
        <.inline_code>.form</.inline_code>
        class acts as a context selector that enables automatic styling for labels, inputs, textareas, selects, checkboxes, and more. Just wrap your form elements and they'll be styled consistently.
      </.prose>

      <.component_demo title="Basic Form" code={basic_code()}>
        <.simple_form class="grid gap-6 max-w-md">
          <div class="grid gap-2">
            <label for="username">Username</label>
            <input type="text" id="username" placeholder="Enter username" />
            <p class="text-muted-foreground text-sm">This is your public display name.</p>
          </div>

          <div class="grid gap-2">
            <label for="email">Email</label>
            <input type="email" id="email" placeholder="m@example.com" />
          </div>

          <.button type="submit">Submit</.button>
        </.simple_form>
      </.component_demo>

      <.section_heading id="various-inputs">Various Input Types</.section_heading>
      <.prose>
        All standard HTML input types are automatically styled.
      </.prose>

      <.component_demo title="Input Types" code={inputs_code()}>
        <.simple_form class="grid gap-6 max-w-md">
          <div class="grid gap-2">
            <label for="password">Password</label>
            <input type="password" id="password" placeholder="Enter password" />
          </div>

          <div class="grid gap-2">
            <label for="date">Date</label>
            <input type="date" id="date" />
          </div>

          <div class="grid gap-2">
            <label for="bio">Bio</label>
            <textarea id="bio" placeholder="Tell us about yourself..." rows="3"></textarea>
          </div>

          <div class="grid gap-2">
            <label for="country">Country</label>
            <select id="country">
              <option value="">Select a country</option>
              <option value="us">United States</option>
              <option value="uk">United Kingdom</option>
              <option value="ca">Canada</option>
            </select>
          </div>
        </.simple_form>
      </.component_demo>

      <.section_heading id="checkboxes-radios">Checkboxes & Radios</.section_heading>
      <.prose>
        Checkboxes and radio buttons are also automatically styled.
      </.prose>

      <.component_demo title="Checkboxes & Radios" code={checks_code()}>
        <.simple_form class="grid gap-6 max-w-md">
          <div class="flex items-center gap-2">
            <input type="checkbox" id="terms" />
            <label for="terms">I agree to the terms and conditions</label>
          </div>

          <fieldset class="grid gap-2">
            <legend class="text-sm font-medium mb-2">Notification preference</legend>
            <div class="flex items-center gap-2">
              <input type="radio" name="notify" id="notify-all" value="all" checked />
              <label for="notify-all">All notifications</label>
            </div>
            <div class="flex items-center gap-2">
              <input type="radio" name="notify" id="notify-important" value="important" />
              <label for="notify-important">Important only</label>
            </div>
            <div class="flex items-center gap-2">
              <input type="radio" name="notify" id="notify-none" value="none" />
              <label for="notify-none">None</label>
            </div>
          </fieldset>
        </.simple_form>
      </.component_demo>

      <.section_heading id="with-liveview">With LiveView Forms</.section_heading>
      <.prose>
        For LiveView forms with changesets, add
        <.inline_code>class="form"</.inline_code>
        to the standard
        <.inline_code>&lt;.form&gt;</.inline_code>
        component.
      </.prose>

      <.code_block language="elixir" code={liveview_code()} />
    </Layouts.docs>
    """
  end

  defp basic_code do
    """
    <.simple_form class="grid gap-6">
      <div class="grid gap-2">
        <label for="username">Username</label>
        <input type="text" id="username" placeholder="Enter username" />
        <p class="text-muted-foreground text-sm">This is your public display name.</p>
      </div>

      <div class="grid gap-2">
        <label for="email">Email</label>
        <input type="email" id="email" placeholder="m@example.com" />
      </div>

      <.button type="submit">Submit</.button>
    </.simple_form>\
    """
  end

  defp inputs_code do
    """
    <.simple_form class="grid gap-6">
      <div class="grid gap-2">
        <label for="password">Password</label>
        <input type="password" id="password" />
      </div>

      <div class="grid gap-2">
        <label for="bio">Bio</label>
        <textarea id="bio" rows="3"></textarea>
      </div>

      <div class="grid gap-2">
        <label for="country">Country</label>
        <select id="country">
          <option value="">Select a country</option>
          <option value="us">United States</option>
        </select>
      </div>
    </.simple_form>\
    """
  end

  defp checks_code do
    """
    <.simple_form class="grid gap-6">
      <div class="flex items-center gap-2">
        <input type="checkbox" id="terms" />
        <label for="terms">I agree to the terms</label>
      </div>

      <fieldset class="grid gap-2">
        <legend>Preference</legend>
        <div class="flex items-center gap-2">
          <input type="radio" name="pref" id="pref-a" />
          <label for="pref-a">Option A</label>
        </div>
        <div class="flex items-center gap-2">
          <input type="radio" name="pref" id="pref-b" />
          <label for="pref-b">Option B</label>
        </div>
      </fieldset>
    </.simple_form>\
    """
  end

  defp liveview_code do
    """
    # For LiveView forms, add class="form" directly:
    <.form for={@form} class="form grid gap-6" phx-submit="save">
      <div class="grid gap-2">
        <label for={@form[:name].id}>Name</label>
        <input type="text" name={@form[:name].name} value={@form[:name].value} />
      </div>
      <.button type="submit">Save</.button>
    </.form>\
    """
  end
end
