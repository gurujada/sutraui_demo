defmodule SutrauiDemoWeb.Components.DialogLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Dialog")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/dialog">
      <.docs_header
        title="Dialog"
        description="Modal dialog using the native HTML dialog element with full accessibility support."
      />

      <.component_demo title="Basic Dialog" code={basic_code()}>
        <.button phx-click={SutraUI.Dialog.show_dialog("basic-dialog")}>
          Open Dialog
        </.button>
        <.dialog id="basic-dialog">
          <:title>Are you sure?</:title>
          <:description>This action cannot be undone.</:description>
          <p class="text-sm text-muted-foreground">
            This will permanently delete your account and all associated data.
          </p>
          <:footer>
            <.button variant="outline" phx-click={SutraUI.Dialog.hide_dialog("basic-dialog")}>
              Cancel
            </.button>
            <.button variant="destructive" phx-click={SutraUI.Dialog.hide_dialog("basic-dialog")}>
              Delete
            </.button>
          </:footer>
        </.dialog>
      </.component_demo>

      <.section_heading id="with-form">With Form</.section_heading>
      <.prose>
        Dialogs work great for form inputs.
      </.prose>

      <.component_demo title="Form Dialog" code={form_code()}>
        <.button phx-click={SutraUI.Dialog.show_dialog("form-dialog")}>
          Edit Profile
        </.button>
        <.dialog id="form-dialog">
          <:title>Edit Profile</:title>
          <:description>Make changes to your profile here.</:description>
          <div class="space-y-4 py-4">
            <.input label="Name" placeholder="Enter your name" />
            <.input label="Email" type="email" placeholder="Enter your email" />
          </div>
          <:footer>
            <.button variant="outline" phx-click={SutraUI.Dialog.hide_dialog("form-dialog")}>
              Cancel
            </.button>
            <.button phx-click={SutraUI.Dialog.hide_dialog("form-dialog")}>
              Save Changes
            </.button>
          </:footer>
        </.dialog>
      </.component_demo>

      <.section_heading id="notes">Notes</.section_heading>
      <.list>
        <.list_item>
          Uses the native
          <.inline_code>&lt;dialog&gt;</.inline_code>
          element with
          <.inline_code>showModal()</.inline_code>
          and <.inline_code>close()</.inline_code>.
        </.list_item>
        <.list_item>
          Focus is automatically trapped within the dialog.
        </.list_item>
        <.list_item>
          Press Escape or click the backdrop to close.
        </.list_item>
        <.list_item>
          ARIA attributes are automatically set based on title and description slots.
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  defp basic_code do
    """
    <.button phx-click={SutraUI.Dialog.show_dialog("my-dialog")}>
      Open Dialog
    </.button>

    <.dialog id="my-dialog">
      <:title>Are you sure?</:title>
      <:description>This action cannot be undone.</:description>
      <p>Dialog content goes here.</p>
      <:footer>
        <.button variant="outline" phx-click={SutraUI.Dialog.hide_dialog("my-dialog")}>
          Cancel
        </.button>
        <.button phx-click={SutraUI.Dialog.hide_dialog("my-dialog")}>
          Confirm
        </.button>
      </:footer>
    </.dialog>\
    """
  end

  defp form_code do
    """
    <.button phx-click={SutraUI.Dialog.show_dialog("form-dialog")}>
      Edit Profile
    </.button>

    <.dialog id="form-dialog">
      <:title>Edit Profile</:title>
      <:description>Make changes to your profile.</:description>
      <div class="space-y-4 py-4">
        <.input label="Name" placeholder="Enter your name" />
        <.input label="Email" type="email" />
      </div>
      <:footer>
        <.button variant="outline" phx-click={SutraUI.Dialog.hide_dialog("form-dialog")}>
          Cancel
        </.button>
        <.button>Save Changes</.button>
      </:footer>
    </.dialog>\
    """
  end
end
