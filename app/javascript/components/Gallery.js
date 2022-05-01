
import React from "react"
import ImageGallery from 'react-image-gallery';

class Gallery extends React.Component {
  render() {
    const images = this.props.images;
    return <ImageGallery items={images} showPlayButton={false}/>;
  }
};

export default Gallery;
