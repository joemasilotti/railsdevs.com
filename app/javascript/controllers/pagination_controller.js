import { Controller } from "@hotwired/stimulus"
import { get } from '@rails/request.js';

export default class extends Controller {
    static targets = ['lastPage', 'loadMoreContainer', 'skeleton']

    static values = {
        url: String,
        page: Number,
    };

    initialize() {
        this.bodyScrollListener = this.bodyScrollListener.bind(this);
        this.pageValue = this.pageValue || 1;
    }

    connect() {
        document.addEventListener("scroll", this.bodyScrollListener);
    }

    disconnect() {
        document.removeEventListener("scroll", this.bodyScrollListener);
        this.element.removeEventListener("scroll", this.scroll);

        super.disconnect();
    }

    async bodyScrollListener() {
        if (this.reachedEndOfBody && this.hasMorePagesLeft && !this.fetching) {
            this._fetchNewPage();
        }
    }

    async _fetchNewPage() {
        this.fetching = true
        await this._performRequest();

        this.pageValue +=1;
        this.fetching = false;
    }

    async _performRequest() {
        await get(this.paginationUrl, {
            responseKind: 'turbo-stream'
        });
    }

    get paginationUrl() {
        return this.urlValue.concat(`${this.urlValue.includes('?')  ? `&page=${this.pageValue}` : `?page=${this.pageValue}`}`);
    }

    get reachedEndOfBody() {
        return (
            document.documentElement.scrollTop >=
            document.documentElement.scrollHeight - document.body.offsetHeight - 100
        );
    }

    get scrollReachedEnd() {
        return (
            this.element.scrollTop >=
            this.element.scrollHeight - this.element.offsetHeight - 100
        );
    }

    get hasMorePagesLeft() {
        return !this.hasLastPageTarget;
    }
}