package com.xmlmachines.beans;

import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: alexb
 * Date: 11/07/15
 * Time: 15:35
 * To change this template use File | Settings | File Templates.
 */
@XmlRootElement()
public class MediaAsset {

    private int width;
    private int height;
    private String file;
    private List<Size> sizes;
    private ImageMetadata image_meta;

    public int getWidth() {
        return width;
    }

    public void setWidth(int width) {
        this.width = width;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public String getFileUri() {
        return file;
    }

    public void setFileUri(String fileUri) {
        this.file = fileUri;
    }

    public List<Size> getSizes() {
        return sizes;
    }

    public void setSizes(List<Size> sizes) {
        this.sizes = sizes;
    }

    public ImageMetadata getMetadata() {
        return image_meta;
    }

    public void setMetadata(ImageMetadata metadata) {
        this.image_meta= metadata;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        MediaAsset that = (MediaAsset) o;

        if (height != that.height) return false;
        if (width != that.width) return false;
        if (!file.equals(that.file)) return false;
        if (!image_meta.equals(that.image_meta)) return false;
        if (!sizes.equals(that.sizes)) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = width;
        result = 31 * result + height;
        result = 31 * result + file.hashCode();
        result = 31 * result + sizes.hashCode();
        result = 31 * result + image_meta.hashCode();
        return result;
    }
}
