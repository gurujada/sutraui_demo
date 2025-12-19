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
          <:footer>
            <.button variant="outline" class="w-full">Cancel</.button>
            <.button class="w-full">Deploy</.button>
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
      <:footer>
        <.button variant="outline" class="w-full">Cancel</.button>
        <.button class="w-full">Deploy</.button>
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
end
