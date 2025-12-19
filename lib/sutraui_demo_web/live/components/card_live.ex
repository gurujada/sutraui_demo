defmodule SutrauiDemoWeb.Components.CardLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Card")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/card">
      <.docs_header
        title="Card"
        description="Container component with header, content, and footer sections."
      />

      <.component_demo title="Full Card" code={full_card_code()}>
        <.card class="w-[350px]">
          <:header>
            <div class="font-semibold">Create project</div>
            <div class="text-sm text-muted-foreground">
              Deploy your new project in one-click.
            </div>
          </:header>
          <:content>
            <div class="space-y-4">
              <.input label="Name" placeholder="Name of your project" />
              <.input label="Framework" placeholder="Select a framework" />
            </div>
          </:content>
          <:footer class="flex justify-end gap-2">
            <.button variant="outline">Cancel</.button>
            <.button>Deploy</.button>
          </:footer>
        </.card>
      </.component_demo>

      <.section_heading id="notification">Notification Card</.section_heading>
      <.prose>
        Cards are perfect for displaying notifications and alerts.
      </.prose>

      <.component_demo title="Notifications" code={notification_code()}>
        <.card class="w-[380px]">
          <:header>
            <div class="flex items-center gap-2">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="size-5"
              >
                <path d="M6 8a6 6 0 0 1 12 0c0 7 3 9 3 9H3s3-2 3-9" />
                <path d="M10.3 21a1.94 1.94 0 0 0 3.4 0" />
              </svg>
              <span class="font-semibold">Notifications</span>
            </div>
            <p class="text-sm text-muted-foreground">You have 3 unread messages.</p>
          </:header>
          <:content>
            <div class="space-y-4">
              <div class="flex items-start gap-4">
                <span class="size-2 mt-2 rounded-full bg-primary shrink-0"></span>
                <div class="space-y-1">
                  <p class="text-sm font-medium">Your call has been confirmed.</p>
                  <p class="text-xs text-muted-foreground">5 min ago</p>
                </div>
              </div>
              <div class="flex items-start gap-4">
                <span class="size-2 mt-2 rounded-full bg-primary shrink-0"></span>
                <div class="space-y-1">
                  <p class="text-sm font-medium">You have a new message!</p>
                  <p class="text-xs text-muted-foreground">1 hour ago</p>
                </div>
              </div>
              <div class="flex items-start gap-4">
                <span class="size-2 mt-2 rounded-full bg-muted shrink-0"></span>
                <div class="space-y-1">
                  <p class="text-sm font-medium">Your subscription is expiring soon.</p>
                  <p class="text-xs text-muted-foreground">2 hours ago</p>
                </div>
              </div>
            </div>
          </:content>
          <:footer class="flex">
            <.button class="w-full">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="mr-2 size-4"
              >
                <polyline points="9 11 12 14 22 4" />
                <path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11" />
              </svg>
              Mark all as read
            </.button>
          </:footer>
        </.card>
      </.component_demo>

      <.section_heading id="simple">Simple Card</.section_heading>
      <.prose>
        Cards can be used with just the content slot for simple use cases.
      </.prose>

      <.component_demo title="Simple" code={simple_code()}>
        <.card class="w-[350px]">
          <:content>
            <p class="text-muted-foreground">
              This is a simple card with only content.
            </p>
          </:content>
        </.card>
      </.component_demo>

      <.section_heading id="stats">Stats Card</.section_heading>
      <.prose>
        Use cards to display metrics and statistics.
      </.prose>

      <.component_demo title="Stats" code={stats_code()}>
        <div class="flex gap-4">
          <.card class="w-[180px]">
            <:header>
              <p class="text-sm text-muted-foreground">Total Revenue</p>
            </:header>
            <:content>
              <div class="text-2xl font-bold">$45,231.89</div>
              <p class="text-xs text-muted-foreground">+20.1% from last month</p>
            </:content>
          </.card>
          <.card class="w-[180px]">
            <:header>
              <p class="text-sm text-muted-foreground">Subscriptions</p>
            </:header>
            <:content>
              <div class="text-2xl font-bold">+2,350</div>
              <p class="text-xs text-muted-foreground">+180.1% from last month</p>
            </:content>
          </.card>
        </div>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp full_card_code do
    """
    <.card class="w-[350px]">
      <:header>
        <div class="font-semibold">Create project</div>
        <div class="text-sm text-muted-foreground">
          Deploy your new project in one-click.
        </div>
      </:header>
      <:content>
        <div class="space-y-4">
          <.input label="Name" placeholder="Name of your project" />
          <.input label="Framework" placeholder="Select a framework" />
        </div>
      </:content>
      <:footer class="flex justify-end gap-2">
        <.button variant="outline">Cancel</.button>
        <.button>Deploy</.button>
      </:footer>
    </.card>\
    """
  end

  defp notification_code do
    """
    <.card class="w-[380px]">
      <:header>
        <div class="flex items-center gap-2">
          <svg class="size-5"><!-- bell icon --></svg>
          <span class="font-semibold">Notifications</span>
        </div>
        <p class="text-sm text-muted-foreground">You have 3 unread messages.</p>
      </:header>
      <:content>
        <div class="space-y-4">
          <div class="flex items-start gap-4">
            <span class="size-2 mt-2 rounded-full bg-primary"></span>
            <div class="space-y-1">
              <p class="text-sm font-medium">Your call has been confirmed.</p>
              <p class="text-xs text-muted-foreground">5 min ago</p>
            </div>
          </div>
          <!-- More notifications... -->
        </div>
      </:content>
      <:footer class="flex">
        <.button class="w-full">Mark all as read</.button>
      </:footer>
    </.card>\
    """
  end

  defp simple_code do
    """
    <.card class="w-[350px]">
      <:content>
        <p class="text-muted-foreground">
          This is a simple card with only content.
        </p>
      </:content>
    </.card>\
    """
  end

  defp stats_code do
    """
    <.card class="w-[180px]">
      <:header>
        <p class="text-sm text-muted-foreground">Total Revenue</p>
      </:header>
      <:content>
        <div class="text-2xl font-bold">$45,231.89</div>
        <p class="text-xs text-muted-foreground">+20.1% from last month</p>
      </:content>
    </.card>\
    """
  end
end
