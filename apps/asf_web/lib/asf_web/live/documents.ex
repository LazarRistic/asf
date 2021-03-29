defmodule AsfWeb.Live.Documents do
  use AsfWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       expanded_docs: [],
       page_title: "Documents"
     )}
  end

  def handle_params(_params, _url, socket) do
    documents = _get_documents()

    {:noreply,
     assign(socket,
       documents: documents
     )}
  end

  def handle_event("toggle_document", %{"id" => id}, socket) do
    expanded_docs = socket.assigns.expanded_docs

    expanded_docs =
      if id in expanded_docs do
        List.delete(expanded_docs, id)
      else
        [id | expanded_docs]
      end

    {:noreply,
     assign(socket,
       expanded_docs: expanded_docs
     )}
  end

  def _get_documents() do
    doc1 = %{
      id: 1,
      title: "GENERAL RULES, SAFETY REQUIREMENTS & AGE REQUIREMENTS",
      posted_at: NaiveDateTime.local_now(),
      content: """
      <ol class="list-decimal list-inside">
        <li><strong>ALL AMERICAN MILSIM EVENTS ARE BIO BBs ONLY!</strong></li>
        <li>All AMS players are highly encouraged to wear “full seal to the face” ANSI 787.1 rated eye protection. However, ANSI 787.1 rated eye protection that is FULL SEAL to the contour of YOUR face is also allowed.</li>
        <li>All players must have a red “Dead Rag” minimum 50 square inches of material. If you don’t have one, please ask. One will be provided for you.</li>
        <li>All weapons must be submitted for inspection to the safety officer. Each player will be asked to fire a minimum of 3 rounds across the chrono. Note that players may be asked to chronograph at any time during the day, including during play.</li>
        <li>Players will be allowed to use only airsoft specific guns.&nbsp; No “BB Guns” or BB guns converted to use airsoft BB’s or Metal BB’s will be allowed.</li>
        <li>While in the staging area, pistols must be holstered. All other weapons must have the magazine removed and the chamber cleared.</li>
        <li>On the Active AO, eye protection may only be removed after all players have mags out, chamber cleared and game control has given the okay to remove goggles.</li>
        <li>While in the staging/parking lot area, you may dry fire your weapon to ensure it is working properly. There is to be no live fire anywhere within the staging area other than the chronograph station.</li>
        <li>All persons moving throughout the AO need to have a waiver on file; this includes observers, photographers, and any additional non-player personnel.</li>
        <li>All players need to have an AMS medical card filled out and in their LEFT SIDED ARM OR LEG POCKET while on the AO.&nbsp; This can be found at: <a class="bbc_url" title="" href="https://americanmilsim.com/wp-content/uploads/2019/05/AMS-med-card-application.pdf">https://americanmilsi…-med-card-application.pdf/</a></li>
        <li>Players under the age of 14 must fill out a minor application and requires the participation of their guardian.</li>
        <li>Players 15 years of age must have a guardian present during the event or fill out a transfer of guardianship to a player 18 years or old who will participate in-game with them.</li>
        <li>Players over the age of 16 are required to have their release form notarized or have a guardian on-site to co-sign the event release form(s).</li>
        <li>These forms can be found at: <a href="https://americanmilsim.com/forms/">https://americanmilsim.com/forms/</a></li>
      </ol>
      """
    }

    doc2 = %{
      id: 2,
      title: "War Crimes",
      posted_at: NaiveDateTime.local_now(),
      content: """
      <ol class="list-decimal list-inside">
        <li>Any rules violations will result in point deductions for your faction.</li>
        <li>Event Staff may ask for your name when a War Crime is recorded, this information will not be made public, but will be used for tracking rules violations internally.</li>
        <li>Safety violations will be assessed higher point penalties.</li>
        <li>Violations involving POVs will incur the highest point penalties.</li>
      </ol>
      """
    }

    doc3 = %{
      id: 3,
      title: "Blind man",
      posted_at: NaiveDateTime.local_now(),
      content: """
      <ol class="list-decimal list-inside">
        <li>On the call of “blind man,” players need to immediately remove the magazine for their weapon, clear the chamber and set the weapon on safe. Stand in your location and do not move until the “all clear” and “game on” is given. Only at that time may you reload your weapon and continue play.</li>
        <li>Use the “blind man” if you or another player is injured and requires immediate Admin/Medical attention. You will need to both vocally and via Comms make the “blind man” call with the approximate location of the incident.</li>
        <li>If a player loses their eye protection during a firefight a “blind man” call is made. The player needs to cover their face with their hands and keep their head down until eye protection can be provided for them.</li>
      </ol>
      """
    }

    doc4 = %{
      id: 4,
      title: "UNIFORMS",
      posted_at: NaiveDateTime.local_now(),
      content: """
        <div>
          <p>Uniform regulations exist to give an appearance of a cohesive unit and not give the appearance of a group of individuals.&nbsp; It is hoped that this will give a better overall experience to all players.</p>
          <ol class="list-decimal list-inside">
            <li>&nbsp;Authorized uniforms only unless announced otherwise. Failure to comply by the uniform requirements will result in ejection from the game.</li>
            <li>Tops should be a BDU/Combat Shirt type uniform top.</li>
            <li>Bottoms must be pants.</li>
            <li>Headgear color will be faction specific.&nbsp; Camo or Solid colors are Authorized.</li>
            <li>In the event of inclement weather, uniformity regulations are relaxed but all worn items must still be faction specific in regards to color.&nbsp; OD Green for CoST and Tan/Brown for UFS.</li>
            <li>Special uniforms may be authorized for specific role-playing groups outside of the typical uniforms but not for those playing under the conventional CoST/UFS Forces.</li>
            <li>Gear color does not matter.&nbsp; You can wear any color gear you wish.</li>
            <li>Ghillie suit colors must match faction base colors.&nbsp; Tan and Green.</li>
            <li>Red shirts may only be worn by AMS Staff.&nbsp; Photographers or observers may wear any high visibility color other than SOLID red.</li>
            <li>Photographers/Observers must not look like combatants.&nbsp; They may wear any type of clothing other than military type uniforms.</li>
          </ol>
        </div>
      """
    }

    [doc1, doc2, doc3, doc4]
  end
end
