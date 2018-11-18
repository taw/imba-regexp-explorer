tag Matches
  def render
    <self>
      <table>
        <tr>
          for i, m in data[0]
            <th>
              if m == 0
                "Match"
              else
                "Group {m}"
        for match in data
          <tr>
            for m in match
              <td>
                m

tag GoodResults
  prop regexp
  prop text

  def scan
    let matches = []
    let match
    while match = regexp.exec(text)
      matches.push(match)
    matches

  def render
    let matches = scan
    <self>
      if matches:length
        <div.results.matches>
          "{matches:length} matches found"
        <Matches[matches]>
      else
        <div.results.no_matches>
          "There are no matches"

tag Results
  prop regexp
  prop text

  def render
    let compiled_regexp
    let ex

    try
      compiled_regexp = RegExp(regexp, "g")
    catch e
      ex = e

    <self>
      if ex
        <div.results.error>
          ex
      else
        <GoodResults regexp=compiled_regexp text=text>

tag App
  def setup
    @regexp = "([A-Z])([a-z]+)"
    @text = "Kitten Ipsum dolor sit amet discovered siamesecalico peaceful her Gizmo peaceful boy rutrum caturday enim lived quis Mauris sit malesuada gf's saved fringilla enim turpis, at mi kitties ham. Venenatis belly cat et boy bat dang saved nulla other porta ipsum mi chilling cat spoon tellus. Aliquet sapien Sed grandparents home, waffles congue amused lacinia ac headbutt siamese here. Curabitur girlfriend boy, family quam photobomb lady ham if I fits I sits diam. Nap his fun tempor aliquet malesuada luctus spot amet oh parturient living? Hiss, lady et a posuere dogs at vehicula."

  def render
    <self>
      <header>
        "RegExp Explorer"
      <div.form>
        <label for="regexp">
          "Regular Expression"
        <input[@regexp]#regexp>
        <label for="text">
          "Tested Text"
        # spellcheck=false but imba doesn't like that
        <textarea[@text]#text>
      <Results regexp=@regexp text=@text>

Imba.mount <App>
