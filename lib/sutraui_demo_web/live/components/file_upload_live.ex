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
      |> allow_upload(:attachments,
        accept: ~w(.pdf .png .zip),
        max_entries: 3,
        max_file_size: 10_000_000
      )
      |> allow_upload(:photos,
        accept: ~w(.jpg .jpeg .png .webp),
        max_entries: 5,
        max_file_size: 5_000_000
      )
      |> allow_upload(:avatar,
        accept: ~w(.jpg .jpeg .png),
        max_entries: 1,
        max_file_size: 2_000_000
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/file-upload">
      <.docs_header
        title="File Upload"
        description="Drag-and-drop file upload built on Phoenix LiveView uploads."
      />

      <.component_demo title="Document Dropzone" code={dropzone_code()}>
        <form phx-change="validate-documents" phx-submit="save-documents" class="w-full max-w-lg">
          <.file_upload
            upload={@uploads.documents}
            label="Upload documents"
            description="PDF, PNG, or ZIP up to 10MB"
          />
        </form>
      </.component_demo>

      <.section_heading id="images">Image Upload With Thumbnails</.section_heading>
      <.prose>
        Set
        <.inline_code>thumbnail</.inline_code>
        to render image previews using Phoenix's
        <.inline_code>live_img_preview/1</.inline_code>
        — perfect for photo galleries and avatars.
      </.prose>

      <.component_demo title="Image Upload" code={images_code()}>
        <form phx-change="validate-photos" phx-submit="save-photos" class="w-full max-w-lg">
          <.file_upload
            upload={@uploads.photos}
            label="Upload photos"
            description="JPG, PNG, or WebP up to 5MB"
            thumbnail
          />
        </form>
      </.component_demo>

      <.section_heading id="avatar">Single File</.section_heading>
      <.prose>
        Use
        <.inline_code>max_entries: 1</.inline_code>
        in
        <.inline_code>allow_upload/3</.inline_code>
        for single-file uploads like avatars. Combined with <.inline_code>thumbnail</.inline_code>, it makes a clean profile photo
        picker.
      </.prose>

      <.component_demo title="Avatar Upload" code={avatar_code()}>
        <form phx-change="validate-avatar" phx-submit="save-avatar" class="w-full max-w-sm">
          <.file_upload
            upload={@uploads.avatar}
            label="Upload profile photo"
            description="JPG or PNG, max 2MB"
            thumbnail
          />
        </form>
      </.component_demo>

      <.section_heading id="custom-content">Custom Dropzone Content</.section_heading>
      <.prose>
        Override the default icon and label with the
        <.inline_code>:drop_content</.inline_code>
        slot. The dropzone keeps its drag-and-drop behavior — you just control
        what's shown inside.
      </.prose>

      <.component_demo title="Custom Content" code={custom_code()}>
        <form phx-change="validate-attachments" phx-submit="save-attachments" class="w-full max-w-lg">
          <.file_upload upload={@uploads.attachments}>
            <:drop_content>
              <span class="text-4xl">📁</span>
              <span class="text-sm font-medium text-foreground">Drop your files here</span>
              <span class="text-xs text-muted-foreground">or click to browse</span>
            </:drop_content>
          </.file_upload>
        </form>
      </.component_demo>

      <.section_heading id="notes">Notes</.section_heading>
      <.list>
        <.list_item>
          Configure accepted types, max entries, and max size in
          <.inline_code>allow_upload/3</.inline_code>
          before rendering the component.
        </.list_item>
        <.list_item>
          Always wrap
          <.inline_code>file_upload</.inline_code>
          in a
          <.inline_code>&lt;form&gt;</.inline_code>
          with
          <.inline_code>phx-change</.inline_code>
          and
          <.inline_code>phx-submit</.inline_code>
          — the upload entries are processed via the form lifecycle.
        </.list_item>
        <.list_item>
          Call
          <.inline_code>consume_uploaded_entries/3</.inline_code>
          in your save handler to copy files to their final destination.
        </.list_item>
        <.list_item>
          The
          <.inline_code>cancel_event</.inline_code>
          attr (default <.inline_code>"cancel-upload"</.inline_code>) must be handled to
          remove entries — it receives
          <.inline_code>upload</.inline_code>
          and
          <.inline_code>ref</.inline_code>
          params for <.inline_code>cancel_upload/3</.inline_code>.
        </.list_item>
        <.list_item>
          Use the
          <.inline_code>:entry</.inline_code>
          slot when you need a fully custom preview row.
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  def handle_event("validate-documents", _params, socket), do: {:noreply, socket}
  def handle_event("save-documents", _params, socket), do: {:noreply, socket}

  def handle_event("validate-attachments", _params, socket), do: {:noreply, socket}
  def handle_event("save-attachments", _params, socket), do: {:noreply, socket}

  def handle_event("validate-photos", _params, socket), do: {:noreply, socket}
  def handle_event("save-photos", _params, socket), do: {:noreply, socket}

  def handle_event("validate-avatar", _params, socket), do: {:noreply, socket}
  def handle_event("save-avatar", _params, socket), do: {:noreply, socket}

  def handle_event("cancel-upload", %{"upload" => upload, "ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, String.to_existing_atom(upload), ref)}
  end

  defp dropzone_code do
    """
    def mount(_params, _session, socket) do
      {:ok,
       allow_upload(socket, :documents,
         accept: ~w(.pdf .png .zip),
         max_entries: 3,
         max_file_size: 10_000_000
       )}
    end

    <form phx-change="validate-documents" phx-submit="save-documents" class="w-full max-w-lg">
      <.file_upload
        upload={@uploads.documents}
        label="Upload documents"
        description="PDF, PNG, or ZIP up to 10MB"
      />
    </form>\
    """
  end

  defp images_code do
    """
    def mount(_params, _session, socket) do
      {:ok,
       allow_upload(socket, :photos,
         accept: ~w(.jpg .jpeg .png .webp),
         max_entries: 5,
         max_file_size: 5_000_000
       )}
    end

    <form phx-change="validate-photos" phx-submit="save-photos" class="w-full max-w-lg">
      <.file_upload
        upload={@uploads.photos}
        label="Upload photos"
        description="JPG, PNG, or WebP up to 5MB"
        thumbnail
      />
    </form>\
    """
  end

  defp avatar_code do
    """
    def mount(_params, _session, socket) do
      {:ok,
       allow_upload(socket, :avatar,
         accept: ~w(.jpg .jpeg .png),
         max_entries: 1,
         max_file_size: 2_000_000
       )}
    end

    <form phx-change="validate-avatar" phx-submit="save-avatar" class="w-full max-w-sm">
      <.file_upload
        upload={@uploads.avatar}
        label="Upload profile photo"
        description="JPG or PNG, max 2MB"
        thumbnail
      />
    </form>\
    """
  end

  defp custom_code do
    """
    def mount(_params, _session, socket) do
      {:ok,
       allow_upload(socket, :attachments,
         accept: ~w(.pdf .png .zip),
         max_entries: 3,
         max_file_size: 10_000_000
       )}
    end

    <form phx-change="validate-attachments" phx-submit="save-attachments" class="w-full max-w-lg">
      <.file_upload upload={@uploads.attachments}>
        <:drop_content>
          <span class="text-4xl">📁</span>
          <span class="text-sm font-medium text-foreground">Drop your files here</span>
          <span class="text-xs text-muted-foreground">or click to browse</span>
        </:drop_content>
      </.file_upload>
    </form>\
    """
  end
end
