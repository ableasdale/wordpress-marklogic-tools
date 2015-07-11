package com.xmlmachines.beans;

/**
 * Created with IntelliJ IDEA.
 * User: alexb
 * Date: 11/07/15
 * Time: 15:44
 * To change this template use File | Settings | File Templates.
 */
public class Size {

    private String name;
    private String file;
    private int width;
    private int height;
    private String mime_type; // note WP calls this "mime-type"

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFileUri() {
        return file;
    }

    public void setFileUri(String fileUri) {
        this.file = fileUri;
    }

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

    public String getMimeType() {
        return mime_type;
    }

    public void setMimeType(String mimeType) {
        this.mime_type = mimeType;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Size size = (Size) o;

        if (height != size.height) return false;
        if (width != size.width) return false;
        if (!file.equals(size.file)) return false;
        if (!mime_type.equals(size.mime_type)) return false;
        if (!name.equals(size.name)) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = name.hashCode();
        result = 31 * result + file.hashCode();
        result = 31 * result + width;
        result = 31 * result + height;
        result = 31 * result + mime_type.hashCode();
        return result;
    }
}
