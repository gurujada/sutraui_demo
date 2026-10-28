defmodule SutrauiDemoWeb.DocsComponents do
  @moduledoc """
  Documentation components - clean and functional.
  """
  use Phoenix.Component

  attr :title, :string, required: true
  attr :description, :string, default: nil

  def docs_header(assigns) do
    ~H"""
    <header class="mb-10">
      <h1 class="page-title">{@title}</h1>
      <p :if={@description} class="page-description mt-3">{@description}</p>
    </header>
    """
  end

  attr :id, :string, default: nil
  slot :inner_block, required: true

  def section_heading(assigns) do
    ~H"""
    <h2
      id={@id}
      class="text-lg font-semibold mt-12 mb-4 scroll-mt-20 sx-1759238"
    >
      {render_slot(@inner_block)}
    </h2>
    """
  end

  attr :id, :string, default: nil
  slot :inner_block, required: true

  def subsection_heading(assigns) do
    ~H"""
    <h3 id={@id} class="text-base font-medium mt-8 mb-3 scroll-mt-20">
      {render_slot(@inner_block)}
    </h3>
    """
  end

  attr :code, :string, required: true
  attr :title, :string, default: nil
  attr :language, :string, default: "heex"
  attr :class, :string, default: nil
  slot :inner_block, required: true

  def component_demo(assigns) do
    ~H"""
    <div class={["demo-container my-6", @class]}>
      <div
        :if={@title}
        class="px-4 py-2 text-xs font-medium border-b sx-f6cfa08"
      >
        {@title}
      </div>

      <div id={"demo-#{System.unique_integer([:positive])}"} phx-hook=".DemoTabs">
        <div class="demo-tabs">
          <button type="button" class="demo-tab active" data-tab="preview">Preview</button>
          <button type="button" class="demo-tab" data-tab="code">Code</button>
          <div class="flex-1"></div>
          <button
            type="button"
            class="demo-copy-btn px-3 text-xs hover:cursor-pointer sx-a2be682"
            aria-label="Copy code"
          >
            <span class="copy-text">Copy</span>
            <span class="check-text hidden sx-246373e">Copied</span>
          </button>
        </div>

        <div class="demo-panel demo-preview">
          {render_slot(@inner_block)}
        </div>

        <div class="demo-panel demo-code hidden">
          <.code_block code={@code} language={@language} />
        </div>
      </div>
    </div>

    <script :type={Phoenix.LiveView.ColocatedHook} name=".DemoTabs">
      import {toast} from "sutra_ui/toast"

      export default {
        mounted() {
          const container = this.el;
          const tabs = container.querySelectorAll('.demo-tab');
          const previewPanel = container.querySelector('.demo-preview');
          const codePanel = container.querySelector('.demo-code');
          const copyBtn = container.querySelector('.demo-copy-btn');
          const copyText = copyBtn?.querySelector('.copy-text');
          const checkText = copyBtn?.querySelector('.check-text');

          tabs.forEach(tab => {
            tab.addEventListener('click', () => {
              tabs.forEach(t => t.classList.remove('active'));
              tab.classList.add('active');

              if (tab.dataset.tab === 'preview') {
                previewPanel.classList.remove('hidden');
                codePanel.classList.add('hidden');
              } else {
                previewPanel.classList.add('hidden');
                codePanel.classList.remove('hidden');
              }
            });
          });

          if (copyBtn) {
            copyBtn.addEventListener('click', async () => {
              const codeEl = codePanel.querySelector('code');
              if (codeEl) {
                await navigator.clipboard.writeText(codeEl.textContent);
                copyText.classList.add('hidden');
                checkText.classList.remove('hidden');

                // Trigger toast notification
                toast("success", "Code copied to the clipboard");

                setTimeout(() => {
                  copyText.classList.remove('hidden');
                  checkText.classList.add('hidden');
                }, 2000);
              }
            });
          }
        }
      }
    </script>
    """
  end

  attr :code, :string, required: true
  attr :language, :string, default: "elixir"
  attr :filename, :string, default: nil

  def code_block(assigns) do
    highlighted =
      case assigns.language do
        "elixir" -> Makeup.highlight(assigns.code, lexer: Makeup.Lexers.ElixirLexer)
        "heex" -> Makeup.highlight(assigns.code, lexer: Makeup.Lexers.ElixirLexer)
        "html" -> Makeup.highlight(assigns.code, lexer: Makeup.Lexers.HTMLLexer)
        _ -> assigns.code
      end

    assigns = assign(assigns, :highlighted, highlighted)

    ~H"""
    <div class="code-block my-4">
      <div :if={@filename} class="code-header">
        <span class="code-filename">{@filename}</span>
      </div>
      <div class="code-body">
        <pre><code>{Phoenix.HTML.raw(@highlighted)}</code></pre>
      </div>
    </div>
    """
  end

  slot :inner_block, required: true

  def inline_code(assigns) do
    ~H"""
    <code class="px-1.5 py-0.5 rounded text-sm sx-3be6047">
      {render_slot(@inner_block)}
    </code>
    """
  end

  slot :inner_block, required: true

  def prose(assigns) do
    ~H"""
    <p class="leading-7 [&:not(:first-child)]:mt-4 sx-a2be682">
      {render_slot(@inner_block)}
    </p>
    """
  end

  attr :variant, :string, default: "info"
  slot :inner_block, required: true

  def callout(assigns) do
    ~H"""
    <div class="my-4 p-4 rounded-lg text-sm leading-relaxed sx-1a3d162">
      {render_slot(@inner_block)}
    </div>
    """
  end

  slot :inner_block, required: true

  def list(assigns) do
    ~H"""
    <ul class="my-4 ml-5 list-disc space-y-1 sx-a2be682">
      {render_slot(@inner_block)}
    </ul>
    """
  end

  slot :inner_block, required: true

  def list_item(assigns) do
    ~H"""
    <li class="leading-7">{render_slot(@inner_block)}</li>
    """
  end

  attr :number, :integer, required: true
  attr :title, :string, required: true
  slot :inner_block, required: true

  def step(assigns) do
    ~H"""
    <div class="relative pl-10 pb-8 last:pb-0">
      <div class="absolute left-0 flex h-6 w-6 items-center justify-center rounded-full text-xs font-medium sx-8cfd7e3">
        {@number}
      </div>
      <div>
        <h3 class="font-medium mb-2">{@title}</h3>
        <div class="sx-a2be682">
          {render_slot(@inner_block)}
        </div>
      </div>
    </div>
    """
  end

  attr :title, :string, required: true
  attr :description, :string, required: true
  slot :icon, required: true

  def feature_card(assigns) do
    ~H"""
    <div class="feature-card">
      <div class="feature-icon">{render_slot(@icon)}</div>
      <h3 class="feature-title">{@title}</h3>
      <p class="feature-description">{@description}</p>
    </div>
    """
  end

  slot :inner_block, required: true

  def props_table(assigns) do
    ~H"""
    <div class="my-4 border rounded-lg overflow-hidden sx-635c873">
      <table class="w-full text-sm">
        <thead>
          <tr class="sx-9507d40">
            <th class="px-4 py-2 text-left font-medium sx-916ff3c">Prop</th>
            <th class="px-4 py-2 text-left font-medium sx-916ff3c">Type</th>
            <th class="px-4 py-2 text-left font-medium sx-916ff3c">Default</th>
            <th class="px-4 py-2 text-left font-medium sx-916ff3c">Description</th>
          </tr>
        </thead>
        <tbody>
          {render_slot(@inner_block)}
        </tbody>
      </table>
    </div>
    """
  end

  attr :name, :string, required: true
  attr :type, :string, required: true
  attr :default, :string, default: "-"
  attr :required, :boolean, default: false
  slot :inner_block, required: true

  def prop(assigns) do
    ~H"""
    <tr class="sx-9459a2d">
      <td class="px-4 py-2">
        <code class="px-1.5 py-0.5 rounded text-xs sx-3be6047">
          {@name}
        </code>
        <span :if={@required} class="ml-1 text-xs sx-5f69581">*</span>
      </td>
      <td class="px-4 py-2 sx-a2be682">
        <code class="text-xs sx-f43dcc6">{@type}</code>
      </td>
      <td class="px-4 py-2 sx-a2be682">
        <code class="text-xs sx-f43dcc6">{@default}</code>
      </td>
      <td class="px-4 py-2 sx-a2be682">
        {render_slot(@inner_block)}
      </td>
    </tr>
    """
  end
end
