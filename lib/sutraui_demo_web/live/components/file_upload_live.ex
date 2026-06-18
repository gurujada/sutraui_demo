defmodule SutrauiDemoWeb.Components.FileUploadLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(page_title: "File Upload")
      |> allow_upload(:documents,
        accept: ~w(.pdf .png .zip),
        max_entries: 3,
        max_file_size: 10_000_000
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/file-upload">
      <.docs_header
        title="File Upload"
        description="Drag-and-drop file upload component built on Phoenix LiveView uploads."
      />

      <.component_demo title="Dropzone" code={dropzone_code()}>
        <form phx-change="validate-upload" phx-submit="save-upload" class="w-full max-w-lg">
          <.file_upload
            upload={@uploads.documents}
            label="Upload documents"
            description="PDF, PNG, or ZIP up to 10MB"
          />
        </form>
      </.component_demo>

      <.section_heading id="custom-content">Custom Content</.section_heading>
      <.prose>
        Override the default dropzone with the
        <.inline_code>:drop_content</.inline_code>
        slot. Pass
        <.inline_code>upload={nil}</.inline_code>
        for a static preview.
      </.prose>

      <.component_demo title="Custom Content" code={custom_code()}>
        <div class="w-full max-w-lg">
          <.file_upload upload={nil}>
            <:drop_content>
              <span class="text-4xl">📁</span>
              <span class="text-sm font-medium text-foreground">Drop your files here</span>
              <span class="text-xs text-muted-foreground">or click to browse</span>
            </:drop_content>
          </.file_upload>
        </div>
      </.component_demo>

      <.section_heading id="image-upload">Image Upload</.section_heading>
      <.prose>
        Restrict accepted types with
        <.inline_code>accept</.inline_code>
        and cap the number of files with
        <.inline_code>max_files</.inline_code>
        .
      </.prose>

      <.component_demo title="Image Upload" code={image_code()}>
        <div class="w-full max-w-lg">
          <.file_upload
            upload={nil}
            accept="image/*"
            label="Upload photos"
            description="JPG or PNG, max 5 files"
          />
        </div>
      </.component_demo>
    </Layouts.docs>
    """
  end

  def handle_event("validate-upload", _params, socket), do: {:noreply, socket}
  def handle_event("save-upload", _params, socket), do: {:noreply, socket}

  def handle_event("cancel-upload", %{"ref" => ref}, socket),
    do: {:noreply, cancel_upload(socket, :documents, ref)}

  defp dropzone_code do
    """
    <form phx-change="validate-upload" phx-submit="save-upload">
      <.file_upload
        upload={@uploads.documents}
        label="Upload documents"
        description="PDF, PNG, or ZIP up to 10MB"
      />
    </form>\
    """
  end

  defp custom_code do
    """
    <.file_upload upload={nil}>
      <:drop_content>
        <span class="text-4xl">📁</span>
        <span class="text-sm font-medium text-foreground">Drop your files here</span>
        <span class="text-xs text-muted-foreground">or click to browse</span>
      </:drop_content>
    </.file_upload>\
    """
  end

  defp image_code do
    """
    <.file_upload
      upload={nil}
      accept="image/*"
      label="Upload photos"
      description="JPG or PNG, max 5 files"
    />\
    """
  end
end
