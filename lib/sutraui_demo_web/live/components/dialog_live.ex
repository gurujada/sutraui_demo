defmodule SutrauiDemoWeb.Components.DialogLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Dialog", open: nil)}
  end

  def handle_event("open-" <> placement, _params, socket) do
    {:noreply, assign(socket, :open, placement)}
  end

  def handle_event("close", _params, socket) do
    {:noreply, assign(socket, :open, nil)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs
      flash={@flash}
      sutra_commands={@sutra_commands}
      current_path="/docs/components/dialog"
    >
      <.docs_header
        title="Dialog"
        description="Modal dialog using a screen-share friendly overlay with accessible dialog semantics."
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

      <.section_heading id="placement">Placement</.section_heading>
      <.prose>
        <.inline_code>placement</.inline_code>
        says where the panel sits. All four are the same div-based dialog: focus is trapped,
        Escape and the backdrop close it. Below 640 px (768 px for <.inline_code>side</.inline_code>) three of them become a bottom sheet.
      </.prose>

      <.component_demo title="Placements" code={placement_code()}>
        <div id="placement-buttons" class="flex flex-wrap gap-3">
          <.button variant="outline" phx-click="open-center">Center</.button>
          <.button variant="outline" phx-click="open-side">Side</.button>
          <.button variant="outline" phx-click="open-sheet">Sheet</.button>
          <.button id="popover-trigger" variant="outline" phx-click="open-popover">Popover</.button>
        </div>

        <.dialog id="placement-center" show={@open == "center"} on_cancel="close">
          <:title>Centred card</:title>
          <:description>The default. Best for a question or a short form.</:description>
          <p class="text-sm text-muted-foreground">Escape, the backdrop or Close all dismiss it.</p>
          <:footer><.button phx-click="close">Close</.button></:footer>
        </.dialog>

        <.dialog
          id="placement-side"
          placement="side"
          size="lg"
          show={@open == "side"}
          on_cancel="close"
        >
          <:title>Filters</:title>
          <:description>
            Docked right and full height from 768 px; a bottom sheet below. size sets the width.
          </:description>
          <div class="space-y-4 py-2">
            <.input
              type="select"
              id="side-status"
              name="status"
              label="Status"
              options={["Open", "Closed", "Waiting"]}
              prompt="Any status"
            />
            <.input
              type="select"
              id="side-owner"
              name="owner"
              label="Owner"
              options={["Asha", "Vikram", "Meera"]}
              prompt="Anyone"
            />
          </div>
          <:footer>
            <.button variant="outline" phx-click="close">Cancel</.button>
            <.button phx-click="close">Apply</.button>
          </:footer>
        </.dialog>

        <.dialog id="placement-sheet" placement="sheet" show={@open == "sheet"} on_cancel="close">
          <:title>Share this page</:title>
          <:description>A bottom sheet on phones, a centred card above.</:description>
          <.input
            id="share-link"
            name="link"
            label="Link"
            value="https://sutraui.example/docs/dialog"
          />
          <:footer><.button phx-click="close">Done</.button></:footer>
        </.dialog>

        <.dialog
          id="placement-popover"
          placement="popover"
          anchor="#popover-trigger"
          show={@open == "popover"}
          on_cancel="close"
        >
          <:title>Why is this blocked?</:title>
          <p class="text-sm text-muted-foreground">
            A popover placement hangs under its anchor with the page visible behind it, from 640 px. Use
            <.inline_code>SutraUI.Popover</.inline_code>
            for a small card beside a button.
          </p>
        </.dialog>
      </.component_demo>

      <.section_heading id="notes">Notes</.section_heading>
      <.list>
        <.list_item>
          Uses a div-based overlay instead of the browser top layer, so dialogs remain
          visible in screen-sharing tools.
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

  defp placement_code do
    """
    <.dialog id="filters" placement="side" size="lg" show={@open == "side"} on_cancel="close">
      ...
    </.dialog>

    <.dialog id="share" placement="sheet" show={@open == "sheet"} on_cancel="close">...</.dialog>

    <.dialog
      id="why"
      placement="popover"
      anchor="#why-trigger"
      show={@open == "popover"}
      on_cancel="close"
    >
      ...
    </.dialog>\
    """
  end
end
