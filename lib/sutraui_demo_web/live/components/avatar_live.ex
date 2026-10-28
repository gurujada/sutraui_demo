defmodule SutrauiDemoWeb.Components.AvatarLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    people = [
      %{name: "Asha Rao", initials: "AR"},
      %{name: "Vikram Nair", initials: "VN"},
      %{name: "Meera Iyer", initials: "MI"},
      %{name: "Rahul Shah", initials: "RS"},
      %{name: "Divya Menon", initials: "DM"},
      %{name: "Kabir Singh", initials: "KS"}
    ]

    {:ok, assign(socket, page_title: "Avatar", people: people)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs
      flash={@flash}
      sutra_commands={@sutra_commands}
      current_path="/docs/components/avatar"
    >
      <.docs_header
        title="Avatar"
        description="An image element with a fallback for representing the user."
      />

      <.component_demo
        title="Default"
        code={~s|<.avatar src="/images/demo/shadcn.jpg" alt="User" />|}
      >
        <.avatar id="avatar-avatar-1" nonce={@csp_nonce} src="/images/demo/shadcn.jpg" alt="User" />
      </.component_demo>

      <.section_heading id="with-initials">With Initials Fallback</.section_heading>
      <.prose>
        Use the
        <.inline_code>initials</.inline_code>
        prop to display fallback text when no image is provided or if the image fails to load.
      </.prose>

      <.component_demo title="Initials" code={initials_code()}>
        <div class="flex items-center gap-4">
          <.avatar initials="JD" />
          <.avatar initials="AB" />
          <.avatar initials="ZK" />
        </div>
      </.component_demo>

      <.section_heading id="sizes">Sizes</.section_heading>
      <.prose>
        Use the
        <.inline_code>size</.inline_code>
        prop to change the avatar size.
      </.prose>

      <.component_demo title="Sizes" code={sizes_code()}>
        <div class="flex items-end gap-4">
          <div class="text-center space-y-2">
            <.avatar
              id="avatar-avatar-2"
              nonce={@csp_nonce}
              src="/images/demo/shadcn.jpg"
              alt="User"
              size="sm"
            />
            <span class="block text-xs sx-a2be682">sm</span>
          </div>
          <div class="text-center space-y-2">
            <.avatar
              id="avatar-avatar-3"
              nonce={@csp_nonce}
              src="/images/demo/shadcn.jpg"
              alt="User"
              size="md"
            />
            <span class="block text-xs sx-a2be682">md</span>
          </div>
          <div class="text-center space-y-2">
            <.avatar
              id="avatar-avatar-4"
              nonce={@csp_nonce}
              src="/images/demo/shadcn.jpg"
              alt="User"
              size="lg"
            />
            <span class="block text-xs sx-a2be682">lg</span>
          </div>
          <div class="text-center space-y-2">
            <.avatar
              id="avatar-avatar-5"
              nonce={@csp_nonce}
              src="/images/demo/shadcn.jpg"
              alt="User"
              size="xl"
            />
            <span class="block text-xs sx-a2be682">xl</span>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="shapes">Shapes</.section_heading>
      <.prose>
        Use the
        <.inline_code>shape</.inline_code>
        prop to switch between circle and square avatars.
      </.prose>

      <.component_demo title="Shapes" code={shapes_code()}>
        <div class="flex items-center gap-4">
          <div class="text-center space-y-2">
            <.avatar
              id="avatar-avatar-6"
              nonce={@csp_nonce}
              src="/images/demo/shadcn.jpg"
              alt="User"
              shape="circle"
            />
            <span class="block text-xs sx-a2be682">circle</span>
          </div>
          <div class="text-center space-y-2">
            <.avatar
              id="avatar-avatar-7"
              nonce={@csp_nonce}
              src="/images/demo/shadcn.jpg"
              alt="User"
              shape="square"
            />
            <span class="block text-xs sx-a2be682">square</span>
          </div>
        </div>
      </.component_demo>

      <.section_heading id="fallback-icon">Custom Fallback Icon</.section_heading>
      <.prose>
        Use the
        <.inline_code>:fallback</.inline_code>
        slot for custom fallback content like icons.
      </.prose>

      <.component_demo title="Custom Fallback" code={fallback_code()}>
        <div class="flex items-center gap-4">
          <.avatar>
            <:fallback>
              <.icon name="lucide-user" class="size-5" />
            </:fallback>
          </.avatar>
          <.avatar>
            <:fallback>
              <.icon name="lucide-users" class="size-5" />
            </:fallback>
          </.avatar>
        </div>
      </.component_demo>

      <.section_heading id="avatar-group">Avatar Group</.section_heading>
      <.prose>
        <.inline_code>avatar_group</.inline_code>
        stacks faces and shows "+n" beyond <.inline_code>max</.inline_code>. Faces are parted by a ring in the background colour.
        It is one
        <.inline_code>role="group"</.inline_code>
        named by
        <.inline_code>label</.inline_code>
        and every name; each face shows its name as a tooltip.
      </.prose>

      <.component_demo title="Avatar Group" code={group_code()}>
        <div class="space-y-4">
          <.avatar_group id="team-group" nonce={@csp_nonce} label="Project team" people={@people} />
          <.avatar_group
            id="team-group-wide"
            nonce={@csp_nonce}
            label="Project team"
            people={@people}
            max={5}
            size="md"
          />
          <.avatar_group
            id="team-group-large"
            nonce={@csp_nonce}
            label="Reviewers"
            people={Enum.take(@people, 2)}
            size="lg"
          />
        </div>
      </.component_demo>

      <.section_heading id="with-status">Presence</.section_heading>
      <.prose>
        <.inline_code>status</.inline_code>
        (<.inline_code>"online"</.inline_code>, <.inline_code>"away"</.inline_code>, <.inline_code>"offline"</.inline_code>)
        adds a small dot cut into the avatar's edge. The dot is decorative and the status is also a screen-reader word, never colour alone.
        In an
        <.inline_code>avatar_group</.inline_code>
        give each person a <.inline_code>:status</.inline_code>; the group's own name lists every status.
      </.prose>

      <.component_demo title="Presence" code={status_code()}>
        <div class="flex flex-wrap items-center gap-6">
          <.avatar
            id="status-online"
            nonce={@csp_nonce}
            src="/images/demo/shadcn.jpg"
            alt="Online user"
            status="online"
          />
          <.avatar initials="JD" status="away" />
          <.avatar initials="AB" status="offline" size="lg" />
          <.avatar_group
            id="status-group"
            nonce={@csp_nonce}
            label="On call"
            people={[
              %{name: "Asha Rao", status: "online"},
              %{name: "Vikram Nair", status: "away"},
              %{name: "Meera Iyer", status: "offline"}
            ]}
          />
        </div>
      </.component_demo>

      <.section_heading id="image-fallback">Image fallback</.section_heading>
      <.prose>
        An image that fails to load falls back to the initials from a small hook. Give the avatar an
        <.inline_code>id</.inline_code>
        (and
        <.inline_code>nonce</.inline_code>
        under a strict CSP); without an
        <.inline_code>id</.inline_code>
        there is no image-failed fallback.
      </.prose>
    </Layouts.docs>
    """
  end

  defp initials_code do
    """
    <.avatar initials="JD" />
    <.avatar initials="AB" />
    <.avatar initials="ZK" />\
    """
  end

  defp sizes_code do
    """
    <.avatar src="/avatar.png" size="sm" />
    <.avatar src="/avatar.png" size="md" />
    <.avatar src="/avatar.png" size="lg" />
    <.avatar src="/avatar.png" size="xl" />\
    """
  end

  defp shapes_code do
    """
    <.avatar src="/avatar.png" shape="circle" />
    <.avatar src="/avatar.png" shape="square" />\
    """
  end

  defp fallback_code do
    """
    <.avatar>
      <:fallback>
        <.icon name="lucide-user" class="size-5" />
      </:fallback>
    </.avatar>\
    """
  end

  defp group_code do
    """
    <.avatar_group id="team" label="Project team" people={[
      %{name: "Asha Rao", initials: "AR"},
      %{name: "Vikram Nair", src: ~p"/images/vikram.png"},
      %{name: "Meera Iyer"}
    ]} max={3} size="sm" />\
    """
  end

  defp status_code do
    """
    <.avatar id="me" nonce={@csp_nonce} src={@user.avatar} alt="Asha" status="online" />
    <.avatar initials="JD" status="away" />

    <.avatar_group id="on-call" label="On call" people={[
      %{name: "Asha Rao", status: "online"},
      %{name: "Vikram Nair", status: "away"}
    ]} />\
    """
  end
end
