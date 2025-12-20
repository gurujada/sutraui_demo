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
        <SutrauiDemoWeb.DocsComponents.kbd>Cmd</SutrauiDemoWeb.DocsComponents.kbd>
        +
        <SutrauiDemoWeb.DocsComponents.kbd>K</SutrauiDemoWeb.DocsComponents.kbd>
        (or
        <SutrauiDemoWeb.DocsComponents.kbd>Ctrl</SutrauiDemoWeb.DocsComponents.kbd>
        +
        <SutrauiDemoWeb.DocsComponents.kbd>K</SutrauiDemoWeb.DocsComponents.kbd>
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
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                class="mr-2"
              >
                <path d="M8 2v4" /><path d="M16 2v4" />
                <rect width="18" height="18" x="3" y="4" rx="2" />
                <path d="M3 10h18" />
              </svg>
              Calendar
            </.command_item>
            <.command_item id="search-emoji">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                class="mr-2"
              >
                <circle cx="12" cy="12" r="10" />
                <path d="M8 14s1.5 2 4 2 4-2 4-2" />
                <line x1="9" x2="9.01" y1="9" y2="9" />
                <line x1="15" x2="15.01" y1="9" y2="9" />
              </svg>
              Search Emoji
            </.command_item>
            <.command_item id="calculator">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                class="mr-2"
              >
                <rect width="16" height="20" x="4" y="2" rx="2" />
                <line x1="8" x2="16" y1="6" y2="6" />
                <line x1="16" x2="16" y1="14" y2="18" />
                <path d="M8 10h.01" /><path d="M12 10h.01" /><path d="M16 10h.01" />
                <path d="M8 14h.01" /><path d="M12 14h.01" />
                <path d="M8 18h.01" /><path d="M12 18h.01" />
              </svg>
              Calculator
            </.command_item>
          </.command_group>
          <.command_separator />
          <.command_group heading="Settings">
            <.command_item id="profile" keywords={["account", "user"]}>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                class="mr-2"
              >
                <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2" />
                <circle cx="12" cy="7" r="4" />
              </svg>
              Profile
            </.command_item>
            <.command_item id="settings" keywords={["preferences", "config"]}>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                class="mr-2"
              >
                <path d="M12.22 2h-.44a2 2 0 0 0-2 2v.18a2 2 0 0 1-1 1.73l-.43.25a2 2 0 0 1-2 0l-.15-.08a2 2 0 0 0-2.73.73l-.22.38a2 2 0 0 0 .73 2.73l.15.1a2 2 0 0 1 1 1.72v.51a2 2 0 0 1-1 1.74l-.15.09a2 2 0 0 0-.73 2.73l.22.38a2 2 0 0 0 2.73.73l.15-.08a2 2 0 0 1 2 0l.43.25a2 2 0 0 1 1 1.73V20a2 2 0 0 0 2 2h.44a2 2 0 0 0 2-2v-.18a2 2 0 0 1 1-1.73l.43-.25a2 2 0 0 1 2 0l.15.08a2 2 0 0 0 2.73-.73l.22-.39a2 2 0 0 0-.73-2.73l-.15-.08a2 2 0 0 1-1-1.74v-.5a2 2 0 0 1 1-1.74l.15-.09a2 2 0 0 0 .73-2.73l-.22-.38a2 2 0 0 0-2.73-.73l-.15.08a2 2 0 0 1-2 0l-.43-.25a2 2 0 0 1-1-1.73V4a2 2 0 0 0-2-2z" />
                <circle cx="12" cy="12" r="3" />
              </svg>
              Settings
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
          <svg class="mr-2"><!-- icon --></svg>
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
