defmodule SutrauiDemoWeb.Components.CommandLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Command")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/command">
      <.docs_header
        title="Command"
        description="A command palette component for fast keyboard-driven navigation and actions."
      />

      <.callout>
        <strong>Try it now!</strong>
        Press
        <.kbd>Cmd</.kbd>
        +
        <.kbd>K</.kbd>
        (or
        <.kbd>Ctrl</.kbd>
        +
        <.kbd>K</.kbd>
        on Windows/Linux) to open this site's command palette.
      </.callout>

      <.section_heading id="inline-command">Inline Command Menu</.section_heading>
      <.prose>
        Use
        <.inline_code>.command</.inline_code>
        for an inline, always-visible command menu.
      </.prose>

      <.component_demo title="Inline Command" code={inline_code()}>
        <.command id="demo-command" placeholder="Search actions..." class="max-w-md">
          <.command_group heading="Suggestions">
            <.command_item id="calendar">
              <.icon name="lucide-calendar" class="mr-2 size-4" /> Calendar
            </.command_item>
            <.command_item id="search-emoji">
              <.icon name="lucide-smile" class="mr-2 size-4" /> Search Emoji
            </.command_item>
            <.command_item id="calculator">
              <.icon name="lucide-calculator" class="mr-2 size-4" /> Calculator
            </.command_item>
          </.command_group>
          <.command_separator />
          <.command_group heading="Settings">
            <.command_item id="profile" keywords={["account", "user"]}>
              <.icon name="lucide-user" class="mr-2 size-4" /> Profile
            </.command_item>
            <.command_item id="settings" keywords={["preferences", "config"]}>
              <.icon name="lucide-settings" class="mr-2 size-4" /> Settings
            </.command_item>
          </.command_group>
        </.command>
      </.component_demo>

      <.section_heading id="command-dialog">Command Dialog</.section_heading>
      <.prose>
        Use
        <.inline_code>.command_dialog</.inline_code>
        for a modal command palette triggered by a keyboard shortcut.
      </.prose>

      <.code_block language="heex" code={dialog_code()} />

      <.section_heading id="keywords">Search Keywords</.section_heading>
      <.prose>
        Add the
        <.inline_code>keywords</.inline_code>
        prop to make items searchable by alternative terms.
      </.prose>

      <.code_block language="heex" code={keywords_code()} />

      <.section_heading id="groups-separators">Groups & Separators</.section_heading>
      <.prose>
        Organize items with
        <.inline_code>.command_group</.inline_code>
        and <.inline_code>.command_separator</.inline_code>.
      </.prose>

      <.code_block language="heex" code={groups_code()} />

      <.section_heading id="js-helpers">JS Helpers</.section_heading>
      <.prose>
        Use the
        <.inline_code>show_command_dialog/1</.inline_code>
        and
        <.inline_code>hide_command_dialog/1</.inline_code>
        functions to control the dialog programmatically.
      </.prose>

      <.code_block language="elixir" code={helpers_code()} />
    </Layouts.docs>
    """
  end

  defp inline_code do
    """
    <.command id="actions" placeholder="Search actions...">
      <.command_group heading="Suggestions">
        <.command_item id="calendar">
          <.icon name="lucide-calendar" class="mr-2 size-4" />
          Calendar
        </.command_item>
        <.command_item id="search">Search</.command_item>
      </.command_group>
      <.command_separator />
      <.command_group heading="Settings">
        <.command_item id="profile">Profile</.command_item>
      </.command_group>
    </.command>\
    """
  end

  defp dialog_code do
    """
    <.command_dialog id="cmd-palette">
      <.command_group heading="Navigation">
        <.command_item id="home" phx-click="navigate" phx-value-to="/">
          Home
        </.command_item>
        <.command_item id="settings" phx-click="navigate" phx-value-to="/settings">
          Settings
        </.command_item>
      </.command_group>
    </.command_dialog>

    <!-- Trigger with keyboard shortcut -->
    <script>
      document.addEventListener('keydown', (e) => {
        if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
          e.preventDefault();
          document.getElementById('cmd-palette').showModal();
        }
      });
    </script>\
    """
  end

  defp keywords_code do
    """
    <.command_item id="settings" keywords={["preferences", "config", "options"]}>
      Settings
    </.command_item>

    <!-- Now searchable by "settings", "preferences", "config", or "options" -->\
    """
  end

  defp groups_code do
    """
    <.command id="menu">
      <.command_group heading="Actions">
        <.command_item id="new">New File</.command_item>
        <.command_item id="open">Open File</.command_item>
      </.command_group>
      
      <.command_separator />
      
      <.command_group heading="Help">
        <.command_item id="docs">Documentation</.command_item>
        <.command_item id="support">Support</.command_item>
      </.command_group>
    </.command>\
    """
  end

  defp helpers_code do
    """
    # Show the command dialog
    <button phx-click={SutraUI.Command.show_command_dialog("cmd-palette")}>
      Open Command Palette
    </button>

    # Hide the command dialog
    <button phx-click={SutraUI.Command.hide_command_dialog("cmd-palette")}>
      Close
    </button>\
    """
  end
end
