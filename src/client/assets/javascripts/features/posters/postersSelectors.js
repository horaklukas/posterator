import {createStructuredSelector} from 'reselect';
import {NAME} from './postersConstants';

const data = (state) => state[NAME];

export const selector = createStructuredSelector({
  data
});

const posters = (state) => state[NAME].posters;

export const postersSelector = createStructuredSelector({
  posters
});

const selectedPoster = (state) => {
	const postersState = state[NAME];

	postersState.posters && postersState.selectedPosterId 
		? postersState.posters[postersState.selectedPosterId] 
		: null;
}

export const selectedPosterSelector = createStructuredSelector({
  selectedPoster
});

const titles = (state) => state[NAME].titles;

export const titlesSelector = createStructuredSelector({
  titles
});