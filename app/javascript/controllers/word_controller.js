import { Controller } from "stimulus"
import $ from 'jquery';
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = ["upvotes", "downvotes"]
  static values = { url: String }

  upvote() {
    const url = `${this.urlValue}?direction=up`
    fetch(url, {
      method: 'POST',
      headers: { 'X-CSRF_Token': Rails.csrfToken() }
    }).then((response) => {
      response.text().then((text) => {
        this.upvotesTarget.innerHTML = text;
      });
    })
  }

  downvote() {
    const url = `${this.urlValue}?direction=down`
    fetch(url, {
      method: 'POST',
      headers: { 'X-CSRF_Token': Rails.csrfToken() }
    }).then((response) => {
      response.text().then((text) => {
        this.downvotesTarget.innerHTML = text;
      });
    })
  }

}
