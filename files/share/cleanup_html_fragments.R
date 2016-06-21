tempM <- data.frame(
  x = letters[1:6],
  y = 1:6,
  message = c("<p>I find the System level to be the most compelling of the three. The schemings of one man, or the belligerent posture of one rogue state, would have limited or no success in a System that was incapable of accommodating such schemings or belligerence. Ala",
                                "<p>Hi, everyone. My name is Josh, and I live in Denver, Colorado. Â This is my second semester at HES and I am working toward an undergraduate degree in Government. I am a business executive for a European company focused on security and fraud in payments ",
                                "<p>Of course I remember. We had some \"vigorous\" discussions. Your push-back helped sharpen my argument though. Good luck with your group project!</p>",
                                "<p>Confirmed</p>\\n<p>Â </p>",
                                "<p>Maroof,</p>\\n<p>Appreciate the follow-up reply.Â </p>\\n<p><span>1- Option A: Hopefully with the successful seating of the GNA in Tripoli, Libya will once again be in a position to seek accession into the WTO. I believe currently they are only observers.",
              "<p>Tensions over AirBnB activity in the West Bank seems like a really interesting topic to cover for this policy paper. A quick primer: <a href=\" http://www.theguardian.com/technology/2016/jan/12/airbnb-listings-illegal-settlements-israel-palestine-west-ban "),
              z = rnorm(6),
                    stringsAsFactors = FALSE)

library(rvest)

tempM$messageClean <- sapply(as.character(tempM$message), function(x) html_text(read_html(x)))
tempM$messageClean <- stri_trans_general(tempM$messageClean, "Latin-ASCII")
tempM$messageClean <- stri_replace_all(tempM$messageClean, " ", fixed="\\n")
