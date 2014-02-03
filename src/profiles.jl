module profiles

using PyCall
import ..data_objects: DataContainer
import ..utils: Field, FieldOrArray
import ..yt_array: YTArray, YTQuantity
@pyimport yt.data_objects.profiles as prof

abstract YTProfile

Limit = Union(Real,YTQuantity)

type Profile1D <: YTProfile
    profile::PyObject
    source::DataContainer
    x_field::Field
    x_bins::Array
    weight_field
    function Profile1D(data_source::DataContainer, x_field::Field, x_n::Integer,
                       x_min::Limit, x_max::Limit, x_log::Bool; weight_field=nothing)
        if weight_field != nothing
            weight = weight_field
        else
            weight = pybuiltin("None")
        end
        if typeof(x_min) == YTQuantity
            xmin = x_min.ytquantity
        else
            xmin = x_min
        end
        if typeof(x_max) == YTQuantity
            xmax = x_max.ytquantity
        else
            xmax = x_max
        end
        profile = prof.Profile1D(data_source.cont, x_field, x_n, xmin, xmax,
                                 x_log, weight_field=weight)
        new(profile, data_source, x_field, profile[:x_bins], weight_field)
    end
end

type Profile2D <: YTProfile
    profile::PyObject
    source::DataContainer
    x_field::Field
    x_bins::Array
    y_field::Field
    y_bins::Array
    weight_field
    function Profile2D(data_source::DataContainer, x_field::Field, x_n::Integer,
                       x_min::Real, x_max::Real, x_log::Bool, y_field::Field,
                       y_n::Integer, y_min::Real, y_max::Real, y_log::Bool;
                       weight_field=nothing)
        if weight_field != nothing
            weight = weight_field
        else
            weight = pybuiltin("None")
        end
        if typeof(x_min) == YTQuantity
            xmin = x_min.ytquantity
        else
            xmin = x_min
        end
        if typeof(x_max) == YTQuantity
            xmax = x_max.ytquantity
        else
            xmax = x_max
        end
        if typeof(y_min) == YTQuantity
            ymin = y_min.ytquantity
        else
            ymin = y_min
        end
        if typeof(y_max) == YTQuantity
            ymax = y_max.ytquantity
        else
            ymax = y_max
        end
        profile = prof.Profile2D(data_source.cont, x_field, x_n, xmin, xmax,
                                 x_log, y_field, y_n, ymin, ymax, y_log,
                                 weight_field=weight)
        new(profile, data_source, x_field, profile[:x_bins], y_field,
            profile[:y_bins], weight_field)
    end
end

type Profile3D <: YTProfile
    profile::PyObject
    source::DataContainer
    x_field::Field
    x_bins::Array
    y_field::Field
    y_bins::Array
    z_field::Field
    z_bins::Array
    weight_field
    function Profile3D(data_source::DataContainer, x_field::Field, x_n::Integer,
                       x_min::Real, x_max::Real, x_log::Bool, y_field::Field,
                       y_n::Integer, y_min::Real, y_max::Real, y_log::Bool,
                       z_field::Field, z_n::Integer, z_min::Real, z_max::Real,
                       z_log::Bool; weight_field=nothing)
        if weight_field != nothing
            weight = weight_field
        else
            weight = pybuiltin("None")
        end
        if typeof(x_min) == YTQuantity
            xmin = x_min.ytquantity
        else
            xmin = x_min
        end
        if typeof(x_max) == YTQuantity
            xmax = x_max.ytquantity
        else
            xmax = x_max
        end
        if typeof(y_min) == YTQuantity
            ymin = y_min.ytquantity
        else
            ymin = y_min
        end
        if typeof(y_max) == YTQuantity
            ymax = y_max.ytquantity
        else
            ymax = y_max
        end
        if typeof(z_min) == YTQuantity
            zmin = z_min.ytquantity
        else
            zmin = z_min
        end
        if typeof(z_max) == YTQuantity
            zmax = z_max.ytquantity
        else
            zmax = z_max
        end
        profile = prof.Profile3D(data_source.cont, x_field, x_n, xmin, xmax,
                                 x_log, y_field, y_n, ymin, ymax, y_log,
                                 z_field, z_n, zmin, zmax, z_log, weight_field=weight)
        new(profile, data_source, x_field, profile[:x_bins], y_field,
            profile[:y_bins], z_field, profile[:z_bins], weight_field)
    end
end

function getindex(profile::YTProfile, key::String)
    YTArray(get(profile.profile, PyObject, key))
end

function getindex(profile::YTProfile, ftype::String, fname::String)
    YTArray(get(profile.profile, PyObject, (ftype,fname)))
end

function add_fields(profile::YTProfile, fields::FieldOrArray)
    profile.profile[:add_fields](fields)
end

function show(io::IO, profile::YTProfile)
    print(io,profile.profile[:__repr__]())
end

end

