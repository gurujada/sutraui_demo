defmodule SutrauiDemoWeb.Components.SelectLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Select")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/select">
      <.docs_header
        title="Select"
        description="Custom select component with search/filter support and full keyboard navigation."
      />

      <.component_demo
        title="Default"
        code={default_code()}
        class="[&_.demo-preview]:min-h-[220px] [&_.demo-preview]:items-start [&_.demo-preview]:pt-4"
      >
        <div class="w-[200px]">
          <.select id="demo-select-1">
            <.select_option value="apple" label="Apple" />
            <.select_option value="banana" label="Banana" />
            <.select_option value="orange" label="Orange" />
          </.select>
        </div>
      </.component_demo>

      <.section_heading id="searchable">Searchable</.section_heading>
      <.prose>
        Enable search to filter through options in large lists.
      </.prose>

      <.component_demo
        title="Searchable"
        code={searchable_code()}
        class="[&_.demo-preview]:min-h-[280px] [&_.demo-preview]:items-start [&_.demo-preview]:pt-4"
      >
        <div class="w-[200px]">
          <.select id="demo-select-2" searchable>
            <.select_option value="apple" label="Apple" />
            <.select_option value="banana" label="Banana" />
            <.select_option value="cherry" label="Cherry" />
            <.select_option value="date" label="Date" />
            <.select_option value="elderberry" label="Elderberry" />
          </.select>
        </div>
      </.component_demo>

      <.section_heading id="with-groups">With Groups</.section_heading>
      <.prose>
        Organize options into logical groups.
      </.prose>

      <.component_demo
        title="With Groups"
        code={groups_code()}
        class="[&_.demo-preview]:min-h-[280px] [&_.demo-preview]:items-start [&_.demo-preview]:pt-4"
      >
        <div class="w-[200px]">
          <.select id="demo-select-3">
            <.select_group label="Fruits">
              <.select_option value="apple" label="Apple" />
              <.select_option value="banana" label="Banana" />
            </.select_group>
            <.select_separator />
            <.select_group label="Vegetables">
              <.select_option value="carrot" label="Carrot" />
              <.select_option value="potato" label="Potato" />
            </.select_group>
          </.select>
        </div>
      </.component_demo>

      <.section_heading id="notes">Usage Notes</.section_heading>
      <.list>
        <.list_item>
          The select component uses the WAI-ARIA combobox pattern for accessibility.
        </.list_item>
        <.list_item>
          Full keyboard navigation: Arrow keys to navigate, Enter/Space to select, Escape to close.
        </.list_item>
        <.list_item>
          A hidden input is rendered for form compatibility.
        </.list_item>
      </.list>
    </Layouts.docs>
    """
  end

  defp default_code do
    """
    <.select id="fruit-select">
      <.select_option value="apple" label="Apple" />
      <.select_option value="banana" label="Banana" />
      <.select_option value="orange" label="Orange" />
    </.select>\
    """
  end

  defp searchable_code do
    """
    <.select id="fruit-select" searchable>
      <.select_option value="apple" label="Apple" />
      <.select_option value="banana" label="Banana" />
      <.select_option value="cherry" label="Cherry" />
    </.select>\
    """
  end

  defp groups_code do
    """
    <.select id="food-select">
      <.select_group label="Fruits">
        <.select_option value="apple" label="Apple" />
        <.select_option value="banana" label="Banana" />
      </.select_group>
      <.select_separator />
      <.select_group label="Vegetables">
        <.select_option value="carrot" label="Carrot" />
        <.select_option value="potato" label="Potato" />
      </.select_group>
    </.select>\
    """
  end
end
