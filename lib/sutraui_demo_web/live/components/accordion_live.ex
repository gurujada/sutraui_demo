defmodule SutrauiDemoWeb.Components.AccordionLive do
  use SutrauiDemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Accordion")}
  end

  def render(assigns) do
    ~H"""
    <Layouts.docs flash={@flash} current_path="/docs/components/accordion">
      <.docs_header
        title="Accordion"
        description="A vertically stacked set of interactive headings that reveal associated content sections."
      />

      <.component_demo title="Basic" code={basic_code()}>
        <.accordion>
          <:item title="Is it accessible?" value="item-1">
            Yes. It adheres to the WAI-ARIA design pattern with proper keyboard navigation.
          </:item>
          <:item title="Is it styled?" value="item-2">
            Yes. It comes with default styles that match the other components' aesthetic.
          </:item>
          <:item title="Is it animated?" value="item-3">
            Yes. It's animated by default with smooth transitions.
          </:item>
        </.accordion>
      </.component_demo>

      <.section_heading id="default-open">Default Open</.section_heading>
      <.prose>
        Use
        <.inline_code>default_value</.inline_code>
        to have an item open by default.
      </.prose>

      <.component_demo title="Default Open" code={default_code()}>
        <.accordion default_value="faq-2">
          <:item title="What is your refund policy?" value="faq-1">
            We offer a 30-day money-back guarantee on all purchases.
          </:item>
          <:item title="How do I contact support?" value="faq-2">
            You can reach our support team at support@example.com or through our help center.
          </:item>
          <:item title="Do you offer bulk discounts?" value="faq-3">
            Yes, we offer discounts for orders of 10 or more items. Contact sales for details.
          </:item>
        </.accordion>
      </.component_demo>

      <.section_heading id="multiple-open">Multiple Open</.section_heading>
      <.prose>
        Set
        <.inline_code>type="multiple"</.inline_code>
        to allow multiple items to be open simultaneously.
      </.prose>

      <.component_demo title="Multiple Mode" code={multiple_code()}>
        <.accordion type="multiple" default_value={["spec-1", "spec-3"]}>
          <:item title="Dimensions" value="spec-1">
            Height: 42mm, Width: 36mm, Depth: 10.7mm
          </:item>
          <:item title="Weight" value="spec-2">
            Aluminum: 38.8g, Stainless Steel: 51.5g
          </:item>
          <:item title="Display" value="spec-3">
            OLED Retina display, 1000 nits brightness
          </:item>
          <:item title="Battery" value="spec-4">
            Up to 18 hours of normal use
          </:item>
        </.accordion>
      </.component_demo>

      <.section_heading id="disabled-items">Disabled Items</.section_heading>
      <.prose>
        Individual items can be disabled with the
        <.inline_code>disabled</.inline_code>
        attribute.
      </.prose>

      <.component_demo title="Disabled Item" code={disabled_code()}>
        <.accordion>
          <:item title="Available Feature" value="feat-1">
            This feature is available for all users.
          </:item>
          <:item title="Premium Feature (Coming Soon)" value="feat-2" disabled>
            This feature is not yet available.
          </:item>
          <:item title="Another Feature" value="feat-3">
            This feature is also available.
          </:item>
        </.accordion>
      </.component_demo>

      <.section_heading id="faq-example">FAQ Example</.section_heading>
      <.prose>
        A common use case for accordions is FAQ sections.
      </.prose>

      <.component_demo title="FAQ Section" code={faq_code()}>
        <.accordion>
          <:item title="How do I create an account?" value="q1">
            Click the "Sign Up" button in the top right corner and follow the registration process.
            You'll need to provide an email address and create a password.
          </:item>
          <:item title="Can I change my username?" value="q2">
            Yes, you can change your username from your account settings. Go to Settings → Profile
            and click on "Edit Username".
          </:item>
          <:item title="How do I reset my password?" value="q3">
            Click "Forgot Password" on the login page. We'll send you an email with instructions
            to reset your password.
          </:item>
          <:item title="Is my data secure?" value="q4">
            Yes, we use industry-standard encryption and security practices to protect your data.
            All connections are secured with TLS 1.3.
          </:item>
        </.accordion>
      </.component_demo>
    </Layouts.docs>
    """
  end

  defp basic_code do
    """
    <.accordion>
      <:item title="Is it accessible?" value="item-1">
        Yes. It adheres to the WAI-ARIA design pattern.
      </:item>
      <:item title="Is it styled?" value="item-2">
        Yes. It comes with default styles.
      </:item>
      <:item title="Is it animated?" value="item-3">
        Yes. It's animated by default.
      </:item>
    </.accordion>\
    """
  end

  defp default_code do
    """
    <.accordion default_value="faq-2">
      <:item title="What is your refund policy?" value="faq-1">
        We offer a 30-day money-back guarantee.
      </:item>
      <:item title="How do I contact support?" value="faq-2">
        Reach us at support@example.com.
      </:item>
    </.accordion>\
    """
  end

  defp multiple_code do
    """
    <.accordion type="multiple" default_value={["spec-1", "spec-3"]}>
      <:item title="Dimensions" value="spec-1">
        Height: 42mm, Width: 36mm
      </:item>
      <:item title="Weight" value="spec-2">
        Aluminum: 38.8g
      </:item>
      <:item title="Display" value="spec-3">
        OLED Retina display
      </:item>
    </.accordion>\
    """
  end

  defp disabled_code do
    """
    <.accordion>
      <:item title="Available Feature" value="feat-1">
        This feature is available.
      </:item>
      <:item title="Premium Feature" value="feat-2" disabled>
        Coming soon.
      </:item>
    </.accordion>\
    """
  end

  defp faq_code do
    """
    <.accordion>
      <:item title="How do I create an account?" value="q1">
        Click "Sign Up" and follow the registration process.
      </:item>
      <:item title="Can I change my username?" value="q2">
        Yes, from Settings → Profile → Edit Username.
      </:item>
      <:item title="How do I reset my password?" value="q3">
        Click "Forgot Password" on the login page.
      </:item>
    </.accordion>\
    """
  end
end
